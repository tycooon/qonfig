# frozen_string_literal: true

describe 'Load from TOML' do
  specify do
    class TomlConfig < Qonfig::DataSet
      load_from_toml SpecSupport.fixture_path('toml_all_in_sample.toml')
    end

    TomlConfig.new.settings.tap do |conf|
      expect(conf.key_in_air).to eq('TOML Example')
      expect(conf.strings.simple_string).to eq('Simple String')
      expect(conf.strings.first_multi_line_string).to eq("first multiline\nstring defined")
      expect(conf.strings.second_multiline_string).to eq("second multiline\nstring defined\n")

      expect(conf.times.first_format).to eq(Time.utc(1979, 0o5, 27, 0o7, 32, 0))
      expect(conf.times.second_format).to eq(Time.new(1979, 0o5, 27, 0o0, 32, 0, '-07:00'))
      expect(conf.times.third_format).to eq(Time.new(1979, 0o5, 27, 0o0, 32, 0.999999, '-07:00'))

      expect(conf.arrays.array_of_integers).to eq([1, 2, 3])
      expect(conf.arrays.array_of_strings).to eq(%w[a b c])
      expect(conf.arrays.array_of_integer_arrays).to eq([[1, 2], [3, 4, 5]])
      expect(conf.arrays.array_of_different_string_literals).to eq(%w[azaza trazaza kek pek])
      expect(conf.arrays.array_of_multityped_arrays).to eq([[1, 2], %w[a b c]])
      expect(conf.arrays.multyline_array).to eq(%w[super puper])

      expect(conf.number_definitions.number_with_parts).to eq([8_001, 8_001, 8_002])
      expect(conf.number_definitions.number_with_idiot_parts).to eq(5_000)
      expect(conf.number_definitions.simple_float).to eq(3.12138)
      expect(conf.number_definitions.epic_float).to eq(5e+22)
      expect(conf.number_definitions.haha_float).to eq(1e6)
      expect(conf.number_definitions.wow_float).to eq(-2E-2)

      expect(conf.booleans.boolean_true).to eq(true)
      expect(conf.booleans.boolean_false).to eq(false)

      expect(conf.nesteds.first.ip).to    eq('10.0.0.1')
      expect(conf.nesteds.first.host).to  eq('google.sru')
      expect(conf.nesteds.second.ip).to   eq('10.0.0.2')
      expect(conf.nesteds.second.host).to eq('poogle.fru')

      expect(conf.deep_nesteds).to eq([
        {
          'name'   => 'apple',
          'first'  => { 'model' => 'iphone xs', 'color' => 'white' },
          'second' => [{ 'model' => 'iphone x' }],
          'third'  => [{ 'model' => 'iphone se' }]
        },
        {
          'name'=>'xiaomi',
          'fourth'=>[{ 'model' => 'mi8 explorer edition' }]
        }
      ])
    end
  end

  describe ':strict mode option (when file does not exist)' do
    context 'when :strict => true (by fefault)' do
      specify 'fails with corresponding error' do
        # check default behaviour (strict: true)
        class FailingTomlConfig < Qonfig::DataSet
          load_from_toml 'no_file.toml'
        end

        expect { FailingTomlConfig.new }.to raise_error(Qonfig::FileNotFoundError)

        class ExplicitlyStrictedTomlConfig < Qonfig::DataSet
          load_from_toml 'no_file.toml', strict: true
        end

        expect { ExplicitlyStrictedTomlConfig.new }.to raise_error(Qonfig::FileNotFoundError)
      end
    end

    context 'when :strict => false' do
      specify 'does not fail - empty config' do
        class NonFailingTomlConfig < Qonfig::DataSet
          load_from_toml 'no_file.toml', strict: false

          setting :nested do
            load_from_toml 'no_file.toml', strict: false
          end
        end

        expect { NonFailingTomlConfig.new }.not_to raise_error
        expect(NonFailingTomlConfig.new.to_h).to eq('nested' => {})
      end
    end
  end
end

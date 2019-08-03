# frozen_string_literal: true

# @api private
# @since 0.13.0
module Qonfig::Validation
  require_relative 'validation/erro'
  require_relative 'validation/method_based'
  require_relative 'validation/proc_based'
  require_relative 'validation/builder'
  require_relative 'validation/dsl'

  class Qonfig::DataSet
    # DSL на датасете
    validate 'a.b.c' do { |value| } # for the concrete setting (and fails whie does not exist)
    end # падает, если несуществующий ключ)
    # VLAUE: canbe settings object or a concrete value

    validate 'a.b.c', by: :check_config_key # once after instantiation (падает, если несуществующий ключ)
    validate { |settings| } # НА ВЕСЬ ИНСТАНС once after instantiatnon
    validate 'a.*' # for each matched pattern !!! (не падает, если не находит)
    validate :mega_key do |peka| # падает, если несуществующий ключ
    end

    # NOTE: заюзать rabbit matcher

    setting :a do
      setting :b, 'kek'
    end
  end

  все валидации запускаются последовательно, накапливая длинный валидэйшн эррор
  в котором представлен список объектов-ошибок

  надо валидаторы гонять КАК после инстанцирования, так и после присавивания значения,
  и перед сохранением в файл конечно же
end

validate => создает validation-комманду, которая будет:

# frozen_string_literal: true

module I18nHelper
  def t(key, options = {})
    I18n.t(key, **options)
  end
end

RSpec.configure do |config|
  config.include I18nHelper
end

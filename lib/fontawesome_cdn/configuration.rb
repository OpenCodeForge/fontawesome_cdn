# frozen_string_literal: true

module FontawesomeCdn
  # Configuration object for FontawesomeCdn.
  #
  # Allows customizing default icon behavior such as:
  # - icon family (classic, brands, duotone, …)
  # - icon style (solid, regular, light, thin)
  # - default aria-hidden attribute
  #
  # This configuration can be set in a Rails initializer:
  #
  #   FontawesomeCdn.configure do |config|
  #     config.default_family = "classic"
  #     config.default_style = "solid"
  #     config.default_aria_hidden = true
  #   end
  #
  class Configuration
    attr_accessor :default_family, :default_style, :default_aria_hidden

    def initialize
      @default_family = :classic
      @default_style = :solid
      @default_aria_hidden = true
    end
  end
end

# frozen_string_literal: true

require "rails/railtie"
require "fontawesome_cdn/helpers"

module FontawesomeCdn
  class Railtie < ::Rails::Railtie
    initializer "fontawesome_cdn.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include FontawesomeCdn::Helpers
      end
    end
  end
end

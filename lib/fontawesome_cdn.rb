# frozen_string_literal: true

require_relative "fontawesome_cdn/version"
require_relative "fontawesome_cdn/configuration"

require "fontawesome_cdn/helpers/include_font_awesome"
require "fontawesome_cdn/helpers/icon"
require "fontawesome_cdn/railtie" if defined?(Rails)

# Rails helpers for loading Font Awesome via CDN.
module FontawesomeCdn
  CDN_BASE_URL = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome"
  KIT_BASE_URL = "https://kit.fontawesome.com"

  # Font Awesome versions supported by the gem
  # SRI hashes provided by cdnjs for all.min.css
  CDN_INTEGRITY_MAP = {
    "7.3.0" => "sha512-ApSLB1Pd3/bZN8fWB/RG9YhN/7bd9Hkf3AGaE2mPfebjrxagjuBtx2GcgdqIlJkUzwylBo61r9Xa9NmgBI0swA==",
    "7.2.0" => "sha512-nMJjQudb6RMMr08oY6YSfNlEWl1l8XWuoOwNvtWXrrgVs8MCR8AZBB1tEAO+ogiI93gXtG1XPmg+bAP5DochSA==",
    "7.1.0" => "sha512-59mflmEHdfG3+iNat6Jg0HZPgYcAhZ7q0VO+q50sfkQDMBpoaSJfjJU2HuH5aBeMZyTwfKB54G8hratLP3Jsow==",
    "7.0.1" => "sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==",
    "7.0.0" => "sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==",
    "6.7.2" => "sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
  }.freeze

  SUPPORTED_VERSIONS = CDN_INTEGRITY_MAP.keys.freeze

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  # Helpers exposed to the Rails views
  module Helpers
    # The methods are added here by the helper files
  end
end

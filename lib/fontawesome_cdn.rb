# frozen_string_literal: true

require_relative "fontawesome_cdn/version"
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
    "7.0.1" => "sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==",
    "7.0.0" => "sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==",
    "6.7.2" => "sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
  }.freeze

  SUPPORTED_VERSIONS = CDN_INTEGRITY_MAP.keys.freeze

  # Helpers exposed to the Rails views
  module Helpers
    # The methods are added here by the helper files
  end
end

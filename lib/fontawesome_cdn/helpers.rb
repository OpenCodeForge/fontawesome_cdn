# frozen_string_literal: true

module FontawesomeCdn
  BASE_URL = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome".freeze

  # Font Awesome versions supported by the gem
  # SRI hashes provided by cdnjs for all.min.css
  INTEGRITY_MAP = {
    "7.0.1" => "sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==",
    "7.0.0" => "sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==",
    "6.7.2" => "sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
  }.freeze

  SUPPORTED_VERSIONS = INTEGRITY_MAP.keys.freeze

  module Helpers
    # Stylesheet helper for loading Font Awesome via CDN
    #
    # Usage:
    #
    #   <%= fontawesome_cdn_stylesheet_tag "7.0.1" %>
    #
    # Raises ArgumentError if version is not supported.
    #
    def fontawesome_cdn_stylesheet_tag(version = nil, **options)
      if version.nil?
        raise ArgumentError,
              "fontawesome_cdn: Font Awesome version is required. " \
                "Usage: <%= fontawesome_cdn_stylesheet_tag \"7.x.x\" %>"
      end

      unless version.is_a?(String)
        raise ArgumentError,
              "fontawesome_cdn: version must be a String, got #{version.class}"
      end

      unless FontawesomeCdn::SUPPORTED_VERSIONS.include?(version)
        raise ArgumentError,
              "fontawesome_cdn: Font Awesome version #{version.inspect} is not supported. " \
                "Supported versions: #{FontawesomeCdn::SUPPORTED_VERSIONS.join(', ')}"
      end

      href = "#{FontawesomeCdn::BASE_URL}/#{version}/css/all.min.css"

      attrs = {
        rel:            "stylesheet",
        href:           href,
        integrity:      FontawesomeCdn::INTEGRITY_MAP[version],
        crossorigin:    "anonymous",
        referrerpolicy: "no-referrer"
      }

      tag.link(**attrs.merge(options))
    end

    # Main helper for displaying an icon
    #
    #   <%= icon "fa-solid", "user" %>
    #   <%= icon "fa-regular", "bell", class: "fa-2x fa-shake" %>
    #   <%= icon "fa-brands", "font-awesome", "Font Awesome" %>
    #   <%= icon "fa-solid", "check", "aria-hidden": false %>
    #
    def icon(style, name, text = nil, html_options = {})
      text, html_options = nil, text if text.is_a?(Hash)

      classes                     = [style, "fa-#{name}", html_options[:class]].compact
      html_options[:class]        = classes.join(" ")
      html_options["aria-hidden"] ||= true

      icon_tag = tag.i(nil, **html_options)

      text.blank? ? icon_tag : safe_join([icon_tag, " ", text.to_s])
    end
  end
end

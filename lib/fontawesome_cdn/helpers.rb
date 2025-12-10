# frozen_string_literal: true

module FontawesomeCdn
  BASE_URL = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome"

  # Font Awesome versions supported by the gem
  # SRI hashes provided by cdnjs for all.min.css
  INTEGRITY_MAP = {
    "7.0.1" => "sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==",
    "7.0.0" => "sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==",
    "6.7.2" => "sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
  }.freeze

  SUPPORTED_VERSIONS = INTEGRITY_MAP.keys.freeze

  ICON_STYLES = %w[solid regular light thin semibold].freeze
  DEFAULT_ICON_STYLE = "solid"

  # Helpers exposed to Rails views.
  #
  # Provides:
  # - fontawesome_cdn_stylesheet_tag(version)
  # - icon(name, text = nil, **options)
  module Helpers
    # Stylesheet helper for loading Font Awesome via CDN
    #
    #   <%= fontawesome_cdn_stylesheet_tag "7.0.1" %>
    #
    # Raises ArgumentError if version is not supported.
    #
    def fontawesome_cdn_stylesheet_tag(version = nil, **options)
      validate_fontawesome_version!(version)

      href = "#{FontawesomeCdn::BASE_URL}/#{version}/css/all.min.css"

      attrs = {
        rel: "stylesheet",
        href: href,
        integrity: FontawesomeCdn::INTEGRITY_MAP[version],
        crossorigin: "anonymous",
        referrerpolicy: "no-referrer"
      }

      tag.link(**attrs, **options)
    end

    # Main helper for displaying an icon
    #
    #   <%= icon "user" %>
    #   <%= icon "gear", "Settings" %>
    #   <%= icon "trash-can", "Delete", style: :regular %>
    #   <%= icon "github", pack: :brands, class: "fa-2x fa-shake" %>
    #
    def icon(name, text = nil, **options)
      # Allow the 2nd argument to be either text or the options hash
      if text.is_a?(Hash)
        options = text
        text = nil
      end

      pack_class, style_class = build_pack_and_style_classes(options)
      options[:class] = [pack_class, style_class, "fa-#{name}", options[:class]].compact.join(" ")
      options["aria-hidden"] = true unless options.key?("aria-hidden") || options.key?(:"aria-hidden")

      icon_tag = tag.i(nil, **options)

      text.nil? || text.to_s.strip.empty? ? icon_tag : safe_join([icon_tag, " ", text.to_s])
    end

    private

    #
    # Font Awesome version validation
    #
    def validate_fontawesome_version!(version)
      raise_version_required_error if version.nil?
      raise_version_type_error(version) unless version.is_a?(String)
      raise_version_not_supported_error(version) unless FontawesomeCdn::SUPPORTED_VERSIONS.include?(version)
    end

    def raise_version_required_error
      raise ArgumentError, <<~MSG
        fontawesome_cdn: Font Awesome version is required.
        Usage: <%= fontawesome_cdn_stylesheet_tag "7.x.x" %>
      MSG
    end

    def raise_version_type_error(version)
      raise ArgumentError, <<~MSG
        fontawesome_cdn: version must be a String, got #{version.class}
      MSG
    end

    def raise_version_not_supported_error(version)
      raise ArgumentError, <<~MSG
        fontawesome_cdn: Font Awesome version #{version.inspect} is not supported.
        Supported versions: #{FontawesomeCdn::SUPPORTED_VERSIONS.join(", ")}
      MSG
    end

    # Classes:
    # - style → fa-solid / fa-regular / ...
    # - pack → fa-brands / ...
    # Special case: brands icons don't use a style like "solid"
    def build_pack_and_style_classes(options)
      pack = options.delete(:pack)&.to_s
      style = options.delete(:style)&.to_s
      style ||= DEFAULT_ICON_STYLE unless pack == "brands"

      validate_icon_style_and_pack!(style, pack)

      [pack, style].compact.map { |c| "fa-#{c}" }
    end

    #
    # Icon validation
    #
    def validate_icon_style_and_pack!(style, pack)
      raise_style_used_as_pack_error(pack) if pack && ICON_STYLES.include?(pack)
      raise_unsupported_icon_style_error(style) if style && !ICON_STYLES.include?(style)
    end

    def raise_style_used_as_pack_error(pack)
      raise ArgumentError, <<~MSG
        fontawesome_cdn: #{pack.inspect} is a style, not a pack.
        Use style: #{pack.inspect} instead.
      MSG
    end

    def raise_unsupported_icon_style_error(style)
      raise ArgumentError, <<~MSG
        fontawesome_cdn: unsupported icon style #{style.inspect}.
        Supported styles: #{ICON_STYLES.join(", ")}
      MSG
    end
  end
end

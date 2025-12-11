# frozen_string_literal: true

module FontawesomeCdn
  # View helpers for rendering Font Awesome icons
  module Helpers
    ICON_STYLES = %w[solid regular light thin semibold].freeze
    DEFAULT_ICON_STYLE = "solid"

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

    # Classes:
    # - style → fa-solid / fa-regular / ...
    # - pack → fa-brands / ...
    # Special case: brands icons don't use a style like "solid"
    def build_pack_and_style_classes(options)
      pack  = options.delete(:pack)&.to_s
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

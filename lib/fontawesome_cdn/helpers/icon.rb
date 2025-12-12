# frozen_string_literal: true

module FontawesomeCdn
  # View helpers for rendering Font Awesome icons
  module Helpers
    FAMILIES = %w[
      classic duotone sharp sharp-duotone brands chisel etch jelly notdog slab
      thumbprint utility whiteboard
    ].freeze

    STYLES = %w[solid regular light thin].freeze

    # Main helper for displaying an icon
    #
    #   <%= icon "user" %>
    #   <%= icon "gear", "Settings" %>
    #   <%= icon "bell", fa: "regular 2x shake" %>
    #   <%= icon "github", "Source code", fa: "brands", class: "link" %>
    #   <%= icon "alien", fa: "duotone light" %>
    #
    def icon(name, text = nil, **options)
      # Allow the 2nd argument to be either text or the options hash
      if text.is_a?(Hash)
        options = text
        text = nil
      end

      aria_hidden =
        if options.key?(:"aria-hidden")
          options.delete(:"aria-hidden")
        else
          FontawesomeCdn.configuration.default_aria_hidden
        end

      class_tokens = options.delete(:class).to_s.split
      fa_tokens = options.delete(:fa).to_s.split.map { |t| "fa-#{t}" }

      tokens = (class_tokens + fa_tokens).uniq

      family = tokens
               .map { |t| t.delete_prefix("fa-") }
               .find { |t| FAMILIES.include?(t) } || FontawesomeCdn.configuration.default_family.to_s

      style = tokens
              .map { |t| t.delete_prefix("fa-") }
              .find { |t| STYLES.include?(t) } || FontawesomeCdn.configuration.default_style.to_s

      # remove family + style from tokens so they can't reappear later
      tokens.delete("fa-#{family}")
      tokens.delete("fa-#{style}")

      classes = []
      classes << "fa-#{family}" unless family == "classic"
      classes << "fa-#{style}" unless family == "brands"
      classes << "fa-#{name}"
      classes.concat(tokens)

      icon_tag = content_tag(:i, nil, class: classes.uniq.join(" "), "aria-hidden": aria_hidden)
      return icon_tag if text.nil? || text.to_s.empty?

      safe_join([icon_tag, ERB::Util.html_escape(text.to_s)], " ")
    end

    private

    def extract_family_and_style(tokens)
      family = tokens.find { |t| FAMILIES.include?(t) }
      style = tokens.find { |t| STYLES.include?(t) }
      [family, style]
    end
  end
end

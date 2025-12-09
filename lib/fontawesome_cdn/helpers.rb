# frozen_string_literal: true

module FontawesomeCdn
  module Helpers
    # Helper to include the Font Awesome stylesheet via CDN
    #
    # Usage in layouts:
    #   <%= fontawesome_cdn_stylesheet_tag %>
    #
    def fontawesome_cdn_stylesheet_tag(options = {})
      href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"

      default_attrs = {
        rel: "stylesheet",
        href: href,
        integrity: "sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==",
        crossorigin: "anonymous",
        referrerpolicy: "no-referrer"
      }

      tag.link(**default_attrs.merge(options))
    end

    # Main helper for displaying an icon
    #
    #   <%= icon "fa-solid", "user" %>
    #   <%= icon "fa-regular", "bell", class: "fa-2x fa-shake" %>
    #   <%= icon "fa-brands", "font-awesome", "Font Awesome" %>
    #   <%= icon "fa-solid", "check", aria: { hidden: false } %>
    #
    def icon(style, name, text = nil, html_options = {})
      text, html_options = nil, text if text.is_a?(Hash)

      classes = [style, "fa-#{name}", html_options[:class]].compact
      html_options[:class] = classes.join(" ")
      html_options["aria-hidden"] ||= true

      icon_tag = tag.i(nil, **html_options)

      text.blank? ? icon_tag : safe_join([icon_tag, " ", text.to_s])
    end
  end
end

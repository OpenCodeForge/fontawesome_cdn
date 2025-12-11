# frozen_string_literal: true

module FontawesomeCdn
  # View helpers for loading Font Awesome assets (CDN or kit)
  module Helpers
    # Helper for loading Font Awesome
    #
    #   <%= include_font_awesome "7.0.1" %>
    #   # => <link rel="stylesheet" ...> to cdnjs
    #
    #   <%= include_font_awesome kit: "YOUR-KIT" %>
    #   # => <script src="https://kit.fontawesome.com/YOUR-KIT.js" crossorigin="anonymous"></script>
    #
    def include_font_awesome(version = nil, kit: nil, **options)
      # Prevent ambiguous usage
      raise ArgumentError, "Use either the version argument or the :kit option, not both" if version && kit

      if kit
        attrs = {
          src: "#{FontawesomeCdn::KIT_BASE_URL}/#{kit}.js",
          crossorigin: "anonymous"
        }

        tag.script(nil, **attrs, **options)
      else
        validate_fontawesome_version!(version)

        attrs = {
          rel: "stylesheet",
          href: "#{FontawesomeCdn::CDN_BASE_URL}/#{version}/css/all.min.css",
          integrity: FontawesomeCdn::CDN_INTEGRITY_MAP[version],
          crossorigin: "anonymous",
          referrerpolicy: "no-referrer"
        }

        tag.link(**attrs, **options)
      end
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
        Usage: <%= include_font_awesome "7.x.x" %> or <%= include_font_awesome kit: "YOUR-KIT" %>
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
  end
end

# frozen_string_literal: true

require "action_view"

RSpec.describe FontawesomeCdn::Helpers, "#include_font_awesome" do
  # Fake view object similar to a Rails view
  let(:view) do
    Class.new do
      include ActionView::Helpers::TagHelper
      include FontawesomeCdn::Helpers
    end.new
  end

  context "when using a version" do
    it "generates a stylesheet link tag" do
      html = view.include_font_awesome("7.0.1").to_s

      expect(html).to include("<link")
      expect(html).to include('rel="stylesheet"')
      expect(html).to include('href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"')
      expect(html).to include(FontawesomeCdn::CDN_INTEGRITY_MAP["7.0.1"])
    end

    it "raises an error when version is nil" do
      expect do
        view.include_font_awesome(nil)
      end.to raise_error(ArgumentError, /version is required/i)
    end

    it "raises an error when version is unsupported" do
      expect do
        view.include_font_awesome("9.9.9")
      end.to raise_error(ArgumentError, /not supported/i)
    end

    it "raises an error when version is not a String" do
      expect do
        view.include_font_awesome(7.0)
      end.to raise_error(ArgumentError, /must be a String/i)
    end
  end

  context "when using a kit" do
    it "generates a script tag" do
      html = view.include_font_awesome(kit: "ABCDE12345").to_s

      expect(html).to eq(
        '<script src="https://kit.fontawesome.com/ABCDE12345.js" crossorigin="anonymous"></script>'
      )
    end
  end

  context "with invalid usage" do
    it "raises an error when both version and kit are provided" do
      expect do
        view.include_font_awesome("7.0.1", kit: "ABCDE12345")
      end.to raise_error(ArgumentError, /either the version argument or the :kit option/i)
    end
  end
end

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
    {
      "7.3.0" => "sha512-ApSLB1Pd3/bZN8fWB/RG9YhN/7bd9Hkf3AGaE2mPfebjrxagjuBtx2GcgdqIlJkUzwylBo61r9Xa9NmgBI0swA==",
      "7.2.0" => "sha512-nMJjQudb6RMMr08oY6YSfNlEWl1l8XWuoOwNvtWXrrgVs8MCR8AZBB1tEAO+ogiI93gXtG1XPmg+bAP5DochSA==",
      "7.1.0" => "sha512-59mflmEHdfG3+iNat6Jg0HZPgYcAhZ7q0VO+q50sfkQDMBpoaSJfjJU2HuH5aBeMZyTwfKB54G8hratLP3Jsow=="
    }.each do |version, integrity|
      it "generates a stylesheet link tag for Font Awesome #{version}" do
        html = view.include_font_awesome(version).to_s
        href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/#{version}/css/all.min.css"

        expect(html).to include(
          "<link", 'rel="stylesheet"', %(href="#{href}"), %(integrity="#{integrity}")
        )
      end
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

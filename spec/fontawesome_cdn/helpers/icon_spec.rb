# frozen_string_literal: true

require "uri"
require "action_view"

RSpec.describe FontawesomeCdn::Helpers, "#icon" do
  subject(:html) { view.icon(name, text, **options) }

  let(:name) { "user" }
  let(:text) { nil }
  let(:options) { {} }

  # Fake view object similar to a Rails view
  let(:view) do
    Class.new do
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::OutputSafetyHelper
      include FontawesomeCdn::Helpers
    end.new
  end

  before do
    # Ensure predictable defaults for specs
    FontawesomeCdn.configure do |c|
      c.default_family = "classic"
      c.default_style = "solid"
      c.default_aria_hidden = true
    end
  end

  context "without text" do
    it "renders an icon using default family/style (classic is omitted)" do
      expect(html).to eq('<i class="fa-solid fa-user" aria-hidden="true"></i>')
    end
  end

  context "with text" do
    let(:text) { "Profile" }

    it "renders the icon followed by the text" do
      expect(html).to eq('<i class="fa-solid fa-user" aria-hidden="true"></i> Profile')
    end
  end

  context "with additional CSS classes" do
    let(:options) { { class: "fa-2x fa-shake" } }

    it "merges the additional classes" do
      expect(html).to eq('<i class="fa-solid fa-user fa-2x fa-shake" aria-hidden="true"></i>')
    end
  end

  context "with fa: tokens" do
    let(:options) { { fa: "regular 2x shake" } }

    it "prefixes tokens with fa- and includes them in the class list" do
      expect(html).to eq('<i class="fa-regular fa-user fa-2x fa-shake" aria-hidden="true"></i>')
    end
  end

  context "with brands family" do
    let(:name) { "github" }
    let(:text) { "Source code" }
    let(:options) { { fa: "brands", class: "link" } }

    it "renders fa-brands without auto-injecting a style class" do
      expect(html).to eq('<i class="fa-brands fa-github link" aria-hidden="true"></i> Source code')
    end
  end

  context "when multiple styles are provided by the user" do
    let(:options) { { fa: "regular", class: "fa-solid fa-2x" } }

    it "does not try to resolve conflicts and keeps user classes" do
      expect(html).to eq('<i class="fa-solid fa-user fa-2x fa-regular" aria-hidden="true"></i>')
    end
  end

  context "when a Hash is passed instead of text" do
    subject(:html) { view.icon(name, text_or_options) }

    let(:name) { "user" }
    let(:text_or_options) { { class: "fa-2x" } }

    it "treats the Hash as html_options" do
      expect(html).to eq('<i class="fa-solid fa-user fa-2x" aria-hidden="true"></i>')
    end
  end

  context "when aria-hidden is overridden" do
    let(:options) { { "aria-hidden": false } }

    it "respects the provided aria-hidden value" do
      expect(html).to include('aria-hidden="false"')
    end
  end

  context "with extra HTML attributes" do
    let(:options) { { style: "color: red" } }

    it "passes extra HTML attributes to the rendered tag" do
      expect(html).to include('style="color: red"')
    end
  end

  context "when defaults are changed via configuration" do
    before do
      FontawesomeCdn.configure do |c|
        c.default_family = "duotone"
        c.default_style = "thin"
      end
    end

    it "uses configured defaults (family is rendered when not classic)" do
      expect(html).to eq('<i class="fa-duotone fa-thin fa-user" aria-hidden="true"></i>')
    end
  end
end

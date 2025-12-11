# frozen_string_literal: true

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

  context "without text" do
    it "renders a solid icon by default" do
      expect(html).to eq('<i class="fa-solid fa-user" aria-hidden="true"></i>')
    end
  end

  context "with text" do
    let(:text) { "Profile" }

    it "renders the icon followed by the text" do
      expect(html).to eq(
        '<i class="fa-solid fa-user" aria-hidden="true"></i> Profile'
      )
    end
  end

  context "with additional CSS classes" do
    let(:options) { { class: "fa-2x fa-shake" } }

    it "merges the additional classes" do
      expect(html).to eq(
        '<i class="fa-solid fa-user fa-2x fa-shake" aria-hidden="true"></i>'
      )
    end
  end

  context "when a Hash is passed instead of text" do
    subject(:html) { view.icon(name, text_or_options) }

    let(:name) { "user" }
    let(:text_or_options) { { class: "fa-2x" } }

    it "treats the Hash as html_options" do
      expect(html).to eq(
        '<i class="fa-solid fa-user fa-2x" aria-hidden="true"></i>'
      )
    end
  end

  context "when aria-hidden is overridden" do
    let(:options) { { "aria-hidden": false } }

    it "respects the provided aria-hidden value" do
      expect(html).to include('aria-hidden="false"')
    end
  end
end

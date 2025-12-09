require "action_view"
require "fontawesome_cdn/helpers"

RSpec.describe FontawesomeCdn::Helpers do
  let(:view) do
    Class.new do
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::OutputSafetyHelper
      include FontawesomeCdn::Helpers
    end.new
  end

  describe "#fontawesome_cdn_stylesheet_tag" do
    let(:version) { "7.0.1" }
    let(:options) { {} }

    subject(:html) { view.fontawesome_cdn_stylesheet_tag(version, **options) }

    context "with a supported version" do
      it "renders a stylesheet link tag with the correct URL" do
        expect(html).to include(
                          'href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"'
                        )
      end

      it "includes the integrity attribute" do
        expect(html).to include('integrity="')
      end

      it "includes crossorigin=anonymous" do
        expect(html).to include('crossorigin="anonymous"')
      end

      it "includes referrerpolicy=no-referrer" do
        expect(html).to include('referrerpolicy="no-referrer"')
      end

      context "with additional HTML options" do
        let(:options) { { media: "all" } }

        it "merges the additional HTML options" do
          expect(html).to include('media="all"')
        end
      end
    end

    context "without a version" do
      let(:version) { nil }

      it "raises an ArgumentError indicating that the version is required" do
        expect { html }.to raise_error(ArgumentError, /version is required/)
      end
    end

    context "with an unsupported version" do
      let(:version) { "9.9.9" }

      it "raises an ArgumentError listing supported versions" do
        expect { html }.to raise_error(ArgumentError, /not supported/)
      end
    end

    context "with a non-string version" do
      let(:version) { 7001 }

      it "raises an ArgumentError about the type" do
        expect { html }.to raise_error(ArgumentError, /must be a String/)
      end
    end
  end

  describe "#icon" do
    subject(:html) { view.icon(style, name, text, **options) }

    let(:style) { "fa-solid" }
    let(:name) { "user" }
    let(:text) { nil }
    let(:options) { {} }

    context "without text" do
      it "renders only the <i> tag with the correct classes and aria-hidden" do
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
        expect(html).to include('class="fa-solid fa-user fa-2x fa-shake"')
      end
    end

    context "when a Hash is passed instead of text" do
      let(:text) { { class: "fa-2x" } }
      let(:options) { {} }

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
  end
end

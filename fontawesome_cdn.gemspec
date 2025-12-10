# frozen_string_literal: true

require_relative "lib/fontawesome_cdn/version"

Gem::Specification.new do |spec|
  spec.name = "fontawesome_cdn"
  spec.version = FontawesomeCdn::VERSION
  spec.summary = "Simple Rails helpers to load Font Awesome from a CDN."
  spec.description = <<~DESC
    Tiny Rails helpers to load Font Awesome via CDN and render icons.
    No asset pipeline integration, no JavaScript, no magic.
  DESC
  spec.authors = ["OpenCodeForge"]
  spec.email = ["contact@opencodeforge.com"]
  spec.homepage = "https://github.com/OpenCodeForge/fontawesome_cdn"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end

  spec.required_ruby_version = ">= 3.0"
  spec.add_dependency "railties", ">= 7.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/OpenCodeForge/fontawesome_cdn",
    "bug_tracker_uri" => "https://github.com/OpenCodeForge/fontawesome_cdn/issues",
    "changelog_uri" => "https://github.com/OpenCodeForge/fontawesome_cdn/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }
end

$:.unshift(File.join(File.dirname(__FILE__), "lib"))

require "latexpdf/version"

_spec = Gem::Specification.new do |s|
  s.name = "latexpdf"
  s.version = Latexpdf::VERSION
  s.summary = "A Tex template to PDF generator"
  s.description = "Latexpdf is a renderer for rails which compiles Tex files with ERB to a PDF using xelatex by default so that it supports Unicode."
  s.authors = ["Matthijs Ooms"]
  s.email = ["matthijs-github@freemo.nl"]
  s.homepage = "https://github.com/mjooms/latexpdf"
  s.license = "MIT"

  s.add_development_dependency "rails",              "~> 7.1.3"
  s.add_development_dependency "sprockets-rails",    "~> 3.4.2"
  s.add_development_dependency "minitest",           "~> 5.22.2"
  s.add_development_dependency "minitest-reporters", "~> 1.1"
  s.add_development_dependency "rake",               "~> 13.1"
  s.add_development_dependency "simplecov",          "~> 0.11"
  s.add_development_dependency "pdf-reader",         "~> 1.4"
  s.add_development_dependency "rubygems-tasks",     "~> 0.2"
  s.add_development_dependency "mocha",              "~> 2.1"

  s.rdoc_options = [%q{--main=README.rdoc}]
  s.extra_rdoc_files = [
      "MIT-LICENSE",
      "README.rdoc"
  ]

  s.files = Dir["lib/**/*"]
  s.test_files    = Dir["test/**/*", "Rakefile"]
  s.require_paths = ["lib"]
end

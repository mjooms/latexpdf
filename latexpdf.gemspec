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

  s.add_development_dependency("minitest")
  s.add_development_dependency("minitest-reporters")
  s.add_development_dependency("rake")
  s.add_development_dependency("simplecov")
  s.add_development_dependency("pdf-reader")

  s.rdoc_options = [%q{--main=README.rdoc}]
  s.extra_rdoc_files = [
      "MIT-LICENSE",
      "README.rdoc"
  ]

  s.files = Dir["lib/**/*"]
  s.test_files    = Dir["test/**/*", "Rakefile"]
  s.require_paths = ["lib"]
end

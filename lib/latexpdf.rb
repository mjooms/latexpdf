
require "rbconfig"
require "logger"
require "securerandom"

# Version
require "latexpdf/version"
require "latexpdf/configuration"

# Errors
require "latexpdf/errors/latexpdf_error"

# Generator
require "latexpdf/pdf_generator"

require "latexpdf/railtie" if defined?(Rails)

module Latexpdf 
  class << self
    attr_writer   :configuration
    attr_writer   :logger
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.logger
    @logger ||= configuration.logger
  end

  def self.compile(tex)
    generator = PdfGenerator.new(tex)
    begin
      generator.generate
      generator.content
    ensure
      generator.cleanup
    end
  end
end

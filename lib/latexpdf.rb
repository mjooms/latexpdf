
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

# Escaper
require "latexpdf/escaper"

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

  def self.compile(tex, target=nil)
    generator = PdfGenerator.new(tex)
    begin
      generator.generate target
      generator.content unless target
    ensure
      generator.cleanup
    end
  end
end

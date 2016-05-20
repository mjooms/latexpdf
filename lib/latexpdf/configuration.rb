module Latexpdf 
  class Configuration
    attr_accessor :passes, :logger, :build_path

    def initialize
      @passes = 2
      @build_path = File.expand_path("../../tmp/", __dir__)
      @logger = Logger.new(STDERR).tap do |log|
        log.progname = "Latexpdf"
      end
    end
  end
end

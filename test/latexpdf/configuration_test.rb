require "test_helper"

module Latexpdf
  class ConfigurationTest < MiniTest::Test
    def test_implement_passes_configuration
      assert_equal 2, Configuration.new.passes
    end

    def test_configure_a_default_logger
      config = Configuration.new

      assert_equal Logger, config.logger.class
      assert_equal "Latexpdf", config.logger.progname
    end
  end
end
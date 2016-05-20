require "test_helper"

module Latexpdf
  class LatexpdfTest < Minitest::Test
    def test_be_able_to_configure_passes
      Latexpdf.configure do |config|
        config.passes = 5
      end
      assert_equal 5, Latexpdf.configuration.passes
    end

    def test_be_able_to_configure_a_logger
      Latexpdf.configure do |config|
        config.logger = "test_logger"
      end
      assert_equal "test_logger", Latexpdf.logger
    end
  end
end

require "test_helper"

module Latexpdf
  class LatexpdfErrorTest < Minitest::Test
    def test_implement_to_s
      e = LatexpdfError.new("message")
      assert_equal "message", e.to_s
    end
  end
end

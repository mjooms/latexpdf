require "test_helper"

class ConfigTest < ActionDispatch::IntegrationTest
  test "Build path is Rails temporary dir by default" do
    assert_equal Rails.configuration.paths['tmp'].first, Latexpdf.configuration.build_path
  end
end

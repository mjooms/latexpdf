require "test_helper"

class RenderingTest < ActionDispatch::IntegrationTest
  test "Generate PDF on the fly in a controller" do
    get "/tex/example.pdf"
    assert_match (/application\/pdf/), response.headers["Content-Type"]
    reader = PDF::Reader.new(StringIO.new(response.body))
    assert_equal 1, reader.pages.count
    assert_match (/Test latex document/), reader.pages.first.text
  end
end
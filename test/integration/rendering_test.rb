require "test_helper"

class RenderingTest < ActionDispatch::IntegrationTest
  test "Generate PDF on the fly in a controller" do
    get "/tex/example.pdf"
    assert_match (/application\/pdf/), response.headers["Content-Type"]
    reader = PDF::Reader.new(StringIO.new(response.body))
    assert_equal 1, reader.pages.count
    assert_match (/Test latex document/), reader.pages.first.text
  end

  test "Generate PDF using escaped characters" do
    get "/tex/example2.pdf"
    assert_match (/application\/pdf/), response.headers["Content-Type"]
    reader = PDF::Reader.new(StringIO.new(response.body))
    assert_equal 1, reader.pages.count
    assert_match (/& % \$ #/), reader.pages.first.text
    assert_match (/\~ \^/), reader.pages.first.text
    # PDF reader does not parse the others correctly unfortunately
  end

  test "Generate PDF using non printable characters" do
    get "/tex/example3.pdf"
    assert_match (/application\/pdf/), response.headers["Content-Type"]
    reader = PDF::Reader.new(StringIO.new(response.body))
    assert_equal 1, reader.pages.count
    assert_match (/tab: END/), reader.pages.first.text
    assert_match (/cr:END/), reader.pages.first.text
    # PDF reader detects sometimes one, sometimes two newlines
    assert_match (/form feed:END/), reader.pages.first.text
  end
end
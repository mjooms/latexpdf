require "simplecov"
SimpleCov.start if ENV["COVERAGE"]

require "latexpdf"
require "minitest/autorun"

old_verbose, $VERBOSE = $VERBOSE, nil
require "pdf-reader"
$VERBOSE = old_verbose

require "minitest/reporters"
Minitest::Reporters.use!

class MockLogger
  def clear
    @messages = {}
  end

  def messages
    @messages ||= {}
  end

  def info(msg)
    msgs = (messages[:info] || Array.new) << msg
    @messages[:info] = msgs
  end

  def error(msg)
  end
end

def test_logger
  @logger ||= MockLogger.new
end

def data_path
  File.join(__dir__, "testdata")
end

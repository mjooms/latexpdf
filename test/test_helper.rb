# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "simplecov"
SimpleCov.start if ENV["COVERAGE"]

require "minitest/autorun"

old_verbose, $VERBOSE = $VERBOSE, nil
require "pdf-reader"
$VERBOSE = old_verbose

require "minitest/reporters"
Minitest::Reporters.use!

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end

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


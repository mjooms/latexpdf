module Latexpdf 
  class LatexpdfError < StandardError
    attr_reader :message

    def initialize(message=nil)
      @message = message
    end

    def to_s
      self.message
    end
  end
end

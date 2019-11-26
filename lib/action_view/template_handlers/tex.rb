module ActionView
  class Template
    module Handlers
      class Tex
        def handles_encoding?; true; end

        class_attribute :default_format
        self.default_format = Mime[:pdf]

        def erb_handler
          @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
        end

        def self.call(template, source)
          new.call(template, source)
        end

        def call(template, source)
          compiled_source = erb_handler.call(template, source)

          "Latexpdf::compile(begin;#{compiled_source};end)"
        end
      end
    end
  end
end

module ActionView
  class Template
    module Handlers
      class Tex
        def handles_encoding?; true; end

        class_attribute :default_format
        self.default_format = Mime::PDF

        def erb_handler
          @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
        end

        def self.call(template)
          new.call(template)
        end

        def call(template)
          compiled_source = erb_handler.call(template)

          "Latexpdf::compile(begin;#{compiled_source};end)"
        end
      end
    end
  end
end

require "action_view/template_handlers/tex"

module Latexpdf
  class Railtie < Rails::Railtie
    config.to_prepare do
      unless Mime.valid_symbols?([:tex])
        Mime::Type.register('application/x-tex', :tex)
      end

      ActionView::Template.register_template_handler :tex, ActionView::Template::Handlers::Tex
      Latexpdf.configure do |c|
        c.build_path = Rails.configuration.paths['tmp'].first
      end
    end
  end
end

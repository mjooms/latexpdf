require "action_view/template_handlers/tex"

module Latexpdf
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActionView::Template.register_template_handler :tex, ActionView::Template::Handlers::Tex
    end
  end
end
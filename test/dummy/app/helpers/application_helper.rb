module ApplicationHelper
  def tex_safe(text)
    Latexpdf.escape_latex(text)
  end
end

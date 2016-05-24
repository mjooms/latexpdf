module Latexpdf
  class Escaper
    ESCAPE_RE=/([{}_$&%#])|([\\^~|<>])/
    ESC_MAP = {
        '\\' => 'backslash',
        '^' => 'asciicircum',
        '~' => 'asciitilde',
        '|' => 'bar',
        '<' => 'less',
        '>' => 'greater',
    }

    def tex_safe(text)
      text.gsub(ESCAPE_RE) { |m|
        if $1
          "\\#{m}"
        else
          "\\text#{ESC_MAP[m]}{}"
        end
      }.html_safe
    end
  end

  def self.escape_latex(text)
    latex_escaper.tex_safe(text)
  end

  private

  def self.latex_escaper
    @latex_escaper ||= Escaper.new
  end
end

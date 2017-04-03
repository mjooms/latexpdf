module Latexpdf
  class Escaper
    ESCAPE_RE=/([{}_$&%#])|([\\^~|<>])/
    ESC_MAP = {
        '\\' => 'backslash',
        '^' => 'asciicircum',
        '~' => 'asciitilde',
        '|' => 'bar',
        '<' => 'less',
        '>' => 'greater'
    }

    def tab_newline_to_space(text)
      text.gsub(/[\x09\x0A]/, " ")
    end

    def remove_non_printable_chars(text)
      pattern = /([\x00-\x08\x0B-\x1F\x7F])/
      text.gsub(pattern, "")
    end

    def tex_safe(text)
      text = text.gsub(ESCAPE_RE) { |m|
        if $1
          "\\#{m}"
        else
          "\\text#{ESC_MAP[m]}{}"
        end
      }
      text = tab_newline_to_space(text)
      text = remove_non_printable_chars(text)
      text.html_safe
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

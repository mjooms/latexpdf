require "test_helper"

module Latexpdf
  class EscaperTest < MiniTest::Test
    def test_escape_ampersand
      assert_equal "\\&", Latexpdf.escape_latex("&")
    end

    def test_escape_dollar
      assert_equal "\\$", Latexpdf.escape_latex("$")
    end

    def test_escape_pound
      assert_equal "\\#", Latexpdf.escape_latex("#")
    end

    def test_escape_underscore
      assert_equal "\\_", Latexpdf.escape_latex("_")
    end

    def test_escape_lcurly
      assert_equal "\\{", Latexpdf.escape_latex("{")
    end

    def test_escape_rcurly
      assert_equal "\\}", Latexpdf.escape_latex("}")
    end

    def test_escape_tilde
      assert_equal "\\textasciitilde{}", Latexpdf.escape_latex("~")
    end

    def test_escape_ciicircum
      assert_equal "\\textasciicircum{}", Latexpdf.escape_latex("^")
    end

    def test_escape_backslash
      assert_equal "\\textbackslash{}", Latexpdf.escape_latex("\\")
    end

    # Although 007F is a valid UTF-8 char, xelatex does not like it
    # Since it is not visible (DELETE) we substitute with nothing
    def test_remove_utf8_delete
      assert_equal "text:", Latexpdf.escape_latex("text:\u007F")
    end

    def test_escape_percent_sign
      assert_equal "\\%", Latexpdf.escape_latex("%")
    end
  end
end

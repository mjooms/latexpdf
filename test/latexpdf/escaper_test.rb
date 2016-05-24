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

    def test_escape_percent_sign
      assert_equal "\\%", Latexpdf.escape_latex("%")
    end
  end
end

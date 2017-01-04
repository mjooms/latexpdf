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
    # Since it is not printable (DELETE) we substitute with nothing
    def test_removes_ascii_del
      text = "\x7F"
      text.force_encoding("UTF-8")
      assert_equal "", Latexpdf.escape_latex(text)
    end

    # One should use newlines
    def test_removes_carriage_return
      text = "test: \x0D"
      text.force_encoding("UTF-8")
      assert_equal "test: ", Latexpdf.escape_latex(text)
    end

    def test_replaces_tab_to_space
      assert_equal "  test ", Latexpdf.escape_latex("\t\ttest\t")
    end

    def test_keeps_newlines
      text = "\ntest\n\n"
      escaped = Latexpdf.escape_latex(text)
      assert_equal text, escaped
    end

    def test_remove_non_printable_chars
      text = [*0..31].map {|i| i.chr }.join
      text.force_encoding("UTF-8")
      escaped_text = Latexpdf.escape_latex(text)

      escaped_newline = Latexpdf.escape_latex("\n")
      escaped_tab = Latexpdf.escape_latex("\t")

      assert_equal escaped_tab + escaped_newline, escaped_text
    end

    def test_escape_percent_sign
      assert_equal "\\%", Latexpdf.escape_latex("%")
    end
  end
end

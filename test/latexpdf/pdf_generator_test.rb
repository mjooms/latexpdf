require "test_helper"

module Latexpdf
  class PdfGeneratorTest < Minitest::Test
    def teardown
      subject.cleanup
    end

    def test_generate_pdf
      subject.generate
      assert File.file?(pdf_file)
      assert_match (/Test latex document/), pdf_reader.pages.first.text
    end

    def test_fail_on_invalid_tex
      invalid_tex_file = File.join(data_path, "invalid_tex.tex.erb")
      @subject = PdfGenerator.new(invalid_tex_file)
      e = assert_raises LatexpdfError do
        subject.generate
      end
      assert_match (/Missing \\begin\{document\}/), e.message
    end

    private

    def subject
      minimal_tex_file = File.join(data_path, "minimal.tex.erb")
      @subject ||= PdfGenerator.new(minimal_tex_file)
    end

    def pdf_file
      subject.pdf_file
    end

    def pdf_reader
      PDF::Reader.new(pdf_file)
    end
  end
end
require "test_helper"

module Latexpdf
  class PdfGeneratorTest < Minitest::Test
    def teardown
      subject.cleanup
    end

    def test_generate_pdf
      set_subject  "minimal.tex"
      subject.generate
      assert File.file?(pdf_file)
      assert_match (/Test latex document/), pdf_reader.pages.first.text
    end

    def test_fail_on_invalid_tex
      set_subject "invalid_tex.tex"
      e = assert_raises LatexpdfError do
        subject.generate
      end
      assert_match (/Missing \\begin\{document\}/), e.message
    end

    def test_fail_on_empty_tex
      set_subject "empty.tex"
      e = assert_raises LatexpdfError do
        subject.generate
      end
      assert_match (/Tex failed: No PDF generated/), e.message
    end

    def test_invokes_tex_N_times
      set_subject  "minimal.tex"

      Latexpdf.configure do |config|
        config.passes = 3
      end

      subject.expects(:run_tex).times(3)

      #since run_tex is mocked, an error occurs
      e = assert_raises LatexpdfError do
        subject.generate
      end
      assert_match (/Tex failed: No PDF generated/), e.message
    end

    protected

    def subject
      @subject
    end

    def set_subject(file)
      tex_file = File.join(data_path, file)
      @subject = PdfGenerator.new(File.read(tex_file))
    end

    def pdf_file
      subject.pdf_file
    end

    def pdf_reader
      PDF::Reader.new(pdf_file)
    end
  end
end
##
# Handles the creation of a PDF
#
# +generate+ will generate a PDF
# +cleanup+ removes the build dir and all related files. Should be called after generation of PDF; also after a failure
# +errors+ will contain latex log on failure
module Latexpdf
  class PdfGenerator
    attr_reader :errors, :template, :pdf_file, :content

    def initialize(tex)
      @template = tex
    end

    def generate
      write_tex
      (Latexpdf.configuration.passes - 1).times do
        run_tex generate_pdf: true
      end
      run_tex generate_pdf: false
      if pdf_exist?
        @pdf_file = target_pdf_file
        @content = File.read(pdf_file)
      else
        raise LatexpdfError.new "Tex failed: No PDF generated"
      end
    end

    def cleanup
      if File.directory?(build_path)
        FileUtils.remove_entry_secure(build_path)
      end
      @build_path = nil
    end

    def pdf_exist?
      File.exist?(target_pdf_file)
    end

    protected

    def build_path
      @build_path ||= make_build_path
    end

    private

    def write_tex
      File.open(target_tex_file, "w") do |f|
        f.write template
        f.close
      end
    end

    def tex_command
      "xelatex"
    end

    def run_tex(generate_pdf: false)
      args = %w[-halt-on-error -shell-escape -interaction batchmode]
      args += %w[-no-pdf] unless generate_pdf
      args = args + ["#{target_tex_file}"]

      result = exec_in_build_path do
        system tex_command, *args, [:out, :err] => "/dev/null"
      end

      raise LatexpdfError.new "Tex failed:\n#{tex_log}" unless result
    end

    def exec_in_build_path
      orig_dir = Dir.pwd
      begin
        Dir.chdir build_path
        yield
      ensure
        Dir.chdir orig_dir
      end
    end

    def tex_log
      @errors ||= File.read(tex_log_file)
    end

    def build_id
      @build_id ||= SecureRandom.uuid
    end

    def make_build_path
      build_dir = Pathname.new(Latexpdf.configuration.build_path)
      new_build_path = build_dir.join(build_id)
      FileUtils.mkdir_p(new_build_path)
      new_build_path
    end

    def target_pdf_file
      build_path.join("input.pdf")
    end

    def tex_log_file
      build_path.join("input.log")
    end

    def target_tex_file
      build_path.join("input.tex")
    end
  end
end
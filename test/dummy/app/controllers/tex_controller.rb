class TexController < ApplicationController
  layout false

  def example
    render "example.pdf.tex"
  end

  def example2
    render "example2.pdf.tex"
  end
end
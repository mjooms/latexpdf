class TexController < ApplicationController
  layout false

  def example
    render "example.pdf.tex"
  end
end
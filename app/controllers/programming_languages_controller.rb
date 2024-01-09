class ProgrammingLanguagesController < ApplicationController
  def index
  end

  def show
    render params[:language]
  end
end

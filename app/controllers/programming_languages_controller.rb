class ProgrammingLanguagesController < ApplicationController
  def index
    render locals: {
      programming_languages: ProgrammingLanguage.all
    }
  end

  def show
    programming_language = ProgrammingLanguage.find!(params[:language])

    render programming_language.slug
  end
end

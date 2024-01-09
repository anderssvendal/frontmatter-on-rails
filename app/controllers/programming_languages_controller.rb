class ProgrammingLanguagesController < ApplicationController
  def index
    render locals: {
      programming_languages: ProgrammingLanguage.all
    }
  end

  def show
    raise ActiveRecord::RecordNotFound unless programming_language?

    # Render the file for the programming language
    render programming_language.slug
  end

  private

  def programming_language
    return nil unless params[:language].present?

    ProgrammingLanguage.find(params[:language])
  end

  def programming_language?
    programming_language.present?
  end

  def page_title
    programming_language.try(:page_title) || super
  end
end

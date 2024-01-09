class ApplicationController < ActionController::Base
  helper_method :page_title

  def page_title
    'Programming languages'
  end
end

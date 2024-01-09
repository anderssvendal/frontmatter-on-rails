Rails.application.routes.draw do
  get '/:language', to: 'programming_languages#show'
  root 'programming_languages#index'
end

Rails.application.routes.draw do
  root 'test#test'
  post '/posttest', to:'test#post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

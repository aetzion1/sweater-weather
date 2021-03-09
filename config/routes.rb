Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
	  namespace :v1 do
      get '/forecast', to: 'weather#forecast', as: 'forecast'
      get '/backgrounds', to: 'weather#background', as: 'backgrounds'
    end
  end
end

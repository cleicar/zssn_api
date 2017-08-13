Rails.application.routes.draw do
  
  root :to => "application#index"

	resources :survivors, only: [:index, :create, :update, :show] do
  	post :flag_infection, on: :member
  end

  resource :reports, only: [] do
  	get 'infected_survivors'
  end

  post :trade_resources, to: 'trades#trade_resources'

  get '*path' => 'application#index'
  
end

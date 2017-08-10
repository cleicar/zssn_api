Rails.application.routes.draw do
  
  root :to => "application#index"

	resources :survivors, only: [:index, :create, :update, :show] do
  	post :flag_infection, on: :member
  end

  get '*path' => 'application#index'
  
end

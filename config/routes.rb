Rails.application.routes.draw do
  resources :survivors
  root :to => "application#index"

	resources :survivors, only: [:index, :create] do
    collection do
    end
  end

  get '*path' => 'application#index'

end

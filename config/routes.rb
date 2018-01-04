Rails.application.routes.draw do
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :home do
    collection do
      get 'search_user'
    end
  end

  resources :following do
    collection do
      get 'follow'
      get 'unfollow'
    end
  end

	devise_scope :user do
    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end

Rails.application.routes.draw do
  resources :tweets do
    member do
    end
    
    collection do
      get 'retweet'
    end    
  end
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :home do
    collection do
      get 'search_user'
      get 'tweets'
    end
  end

  resources :following do
    collection do
      get 'follow'
      get 'unfollow'
      get 'following_list'
    end
  end

  resources :likes do
    collection do
      get 'like'
      get 'dislike'
    end
  end

  resources :comments do
    collection do
      post 'create_comment' 
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

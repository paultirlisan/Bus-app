Rails.application.routes.draw do
	resources :stations, only: [:new, :create, :edit, :update, :destroy]
	resources :routes, only: [:new, :create, :edit, :update, :destroy]
	resources :journeys, only: [:create, :destroy]
	resources :companies, only: [:show] do
		member do
			get 'careers'
			get 'contact'
		end
	end

  	mount Ckeditor::Engine => '/ckeditor'
	devise_for :users, controllers: { sessions: 'users/sessions', 
		registrations: 'users/registrations' }

	root "static_pages#home"
	get "history", to: "static_pages#history"
end

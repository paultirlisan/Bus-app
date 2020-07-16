Rails.application.routes.draw do
	resources :stations, only: [:new, :create, :edit, :update, :destroy]

  	mount Ckeditor::Engine => '/ckeditor'
	devise_for :users, controllers: { sessions: 'users/sessions', 
		registrations: 'users/registrations' }

	root "static_pages#home"
end

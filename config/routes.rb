Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
	devise_for :users, controllers: { sessions: 'users/sessions', 
		registrations: 'users/registrations' }

	root "static_pages#home"
end

Rails.application.routes.draw do
	mount GrapeSwaggerRails::Engine => '/documentation'
  mount API::Base => '/'
  devise_for :users, :skip => [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :tests
  root 'users#index'

end

Rails.application.routes.draw do
  resources :task_types
  resources :tasks
  resources :projects
  resources :diagrams
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#new"
end

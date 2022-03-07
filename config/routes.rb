Rails.application.routes.draw do
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end


  # specific definitions go first or else get overwritten by default definitions
  get 'nominators/user_new', to: 'nominators#user_new', as: 'user_new_nominator'
  get 'nominators/:id/students/user_new/', to: 'students#user_new', as: 'user_new_student' #pass nominator id to new student form
  get 'nominators/:id/finish/', to: 'nominators#finish', as: 'finish' # finish page
  get 'admin', to: 'students#admin', as: 'admin' # admin home page in student folder for now
  get 'admin/update_max', to: 'students#update_max', as: 'update_max'
  post 'nominator/user_create', to: 'nominators#user_create', as: 'ucreate_nominators'
  post 'students/user_create', to: 'students#user_create', as: 'ucreate_students'
  post 'students/:id', to: 'students#user_destroy', as: 'udestroy_students'

  # add new functions/pages to separate user and admin views
  resources :nominators do
    member do
      get :user_show
      get :user_edit
      patch :user_update
    end
  end

  resources :students do
    resources :responses
    member do
      get :user_show
      get :user_edit
      patch :user_update
    end
  end

  # default definitions and root
  resources :universities
  resources :nominators
  resources :students


  resources :responses
  resources :questions do
	resources :answers
  #root "dashboards#show"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

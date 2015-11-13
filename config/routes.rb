Rails.application.routes.draw do
  root 'site/home#index'

  resources :loads do
    get :dispatch, controller: 'loads/dispatch', action: :edit
    patch :dispatch, controller: 'loads/dispatch', action: :update
    patch :quickdispatch, controller: 'loads/dispatch', action: :quickupdate
    patch :ship, controller: 'loads/ship', action: :update
  end
end

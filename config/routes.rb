Rails.application.routes.draw do
  resources :contacts do
    delete 'destroy_all', on: :collection
  end

  root 'contacts#index'
end

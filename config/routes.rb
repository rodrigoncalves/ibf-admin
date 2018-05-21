Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
end

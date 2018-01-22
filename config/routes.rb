Rails.application.routes.draw do
  resources :rooms do
    resources :bookings
  end
end

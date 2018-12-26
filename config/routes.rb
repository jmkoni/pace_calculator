Rails.application.routes.draw do
  root to: "pace_calculator#index"
  get 'pace', to: "pace_calculator#pace"
end

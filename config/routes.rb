Rails.application.routes.draw do
  root to: "pace_calculator#index"
  get 'run', to: "pace_calculator#run"
end

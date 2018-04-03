Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  namespace :admin do
    get "/" => "welcome#index"
  end


  get '/average_data' => "shang_hai_restaurant#average_data"
  get '/total_data' => "shang_hai_restaurant#total_data"

  get '/average' => "shang_hai_restaurant#average"
  get '/total' => "shang_hai_restaurant#total"
  namespace :admin do
    # sidekiq monitors
    require 'sidekiq/web'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      # Protect against timing attacks: (https://codahale.com/a-lesson-in-timing-attacks/)
      # - Use & (do not use &&) so that it doesn't short circuit.
      # - Use `variable_size_secure_compare` to stop length information leaking
      ActiveSupport::SecurityUtils.variable_size_secure_compare(username, 'admin') &
          ActiveSupport::SecurityUtils.variable_size_secure_compare(password, 'sidekiq_admin')
    end
    mount Sidekiq::Web => '/sidekiq'
  end
end

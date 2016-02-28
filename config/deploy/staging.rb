server '52.77.47.185',
  user: 'deploy',
  roles: %w{web app db}

set :stage, :production
set :branch, 'staging'
set :keep_releases, 5
set :rails_env, 'production'
set :whenever_environment, 'production'

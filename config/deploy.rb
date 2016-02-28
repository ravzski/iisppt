
require 'net/ssh/proxy/command'

lock '3.4.0'

set :application, 'scm'
set :repo_url, 'git@github.com:ravzski/iisppt.git'
set :deploy_to, '/home/deploy/'
set :format, :pretty
set :log_level, :debug
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle config/thin}
set :assets_roles, [:app]
set :rvm_ruby_version, '2.3.0@iisppt'
set :bundle_without, [:development, :test]

load "config/deploy/tasks.rb"


namespace :deploy do
  after :publishing, :restart
end

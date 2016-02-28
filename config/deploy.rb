require 'net/ssh/proxy/command'

# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'iisppt'
set :repo_url, 'git@github.com:ravzski/iisppt.git'
set :deploy_via, :remote_cache
set :bundle_without, [:development, :test]

set :iisppt, :git
set :log_level, :debug
set :pty, false
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle config/thin}
set :assets_roles, [:app]

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_flags, '--deployment'

set :rvm_ruby_version, '2.3.0@iisppt'
set :deploy_to, "/home/deploy/"

load "config/deploy/tasks.rb"

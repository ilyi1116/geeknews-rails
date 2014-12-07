# config valid only for current version of Capistrano
lock '3.3.3'


set :application, 'geeknews'
#set :repo_url, 'git@example.com:me/my_repo.git'
set :repo_url, 'https://github.com/tjnet/geeknews-rails.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/rails/geeknews'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system' 'bundle' 'public/assets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
set :unicorn_rack_env, "none"
set :unicorn_config_path, 'config/unicorn.rb'

# setting for whenever
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  desc "Create dragonfly directory"
  task :create_dragonfly_dir do
    on roles(:app) do |host|
      if test "[ ! -d #{release_path}/public/system/dragonfly/production ]"
        execute "mkdir -p #{release_path}/public/system/dragonfly/production"
      end
    end
  end

  # if preload_app:true  and you need capistrano 
  # to cleanup your oldbin pid use:
  desc 'Restart application'
  task :restart do
    #invoke 'unicorn:legacy_restart'
    invoke 'unicorn:reload'
  end

  # 
  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end
  

  desc 'execute create database before deploy'
  task :db_create do
    on roles(:db) do |host|
      execute "mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS geeknews_production;'"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end


  before :starting, :upload
  before :publishing, :create_dragonfly_dir
  after :publishing, :restart

end

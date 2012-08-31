require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/postgresql"
load "config/recipes/rbenv"
load "config/recipes/trinidad"

server "198.58.96.26", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "blog"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false

set :deploy_via, :copy
set :repository, "."
set :copy_exclude, %w[.git log tmp .DS_Store]
set :scm, :none

default_run_options[:pty] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# To setup new Ubuntu 12.04 server:
# ssh root@198.58.96.26
# adduser deployer
# echo "deployer ALL=(ALL:ALL) ALL" >> /etc/sudoers
# exit
# ssh-copy-id deployer@198.58.96.26
# cap deploy:install
# cap deploy:setup
# cap deploy:cold

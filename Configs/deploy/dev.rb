set :application, 'budcruisedev'
set :user, "deployuser"
set :repository, "ssh://git@stash.rehabstudio.com:7999/bud/bud-light-hotel-24hr-game.git"
set :branch, 'backend'
set :deploy_to, "/var/www/budcruiseapi.dev.rehabstudio.com"
set :clear_cache, true
set :cake_branch, "origin/master"
set :use_composer, true
set :copy_vendors, true
# set :update_vendors, true
server "54.193.45.100", :web, :app

set :stages, %w(dev staging)
set :stage_dir, 'Configs/deploy'
set :default_stage, 'dev'
require 'rubygems'
require 'capistrano/ext/multistage'
require 'app-deployer'

namespace :hooks do
  task :symlink do
    run "ln -s #{shared_path}/tmp/ #{current_path}/tmp"
    run "ln -s #{shared_path}/Configs/Connection.php #{current_path}/Configs/Connection.php"
  end
end

after 'deploy:create_symlink', 'hooks:symlink'

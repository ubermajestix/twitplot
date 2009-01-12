set :application, "twitplot"

#SCM settings
set :repository,  "git@github.com:ubermajestix/twitplot.git"
set :scm, "git"
set :branch, "origin/master"
# set :repository_cache, "git_cache"
 set :deploy_via, :remote_cache


# Sudoer settings      
set :use_sudo               , true
set :user                   , "tyler"
set :runner                 , "root"
default_run_options[:shell] = false
default_run_options[:pty]   = true
set :ssh_options, { :forward_agent => true }
set :chmod755, "app config db lib public vendor script script/* public/disp*"

# Deployment servers
role :app, "twitplot.com"
role :web, "twitplot.com"
role :db,  "twitplot.com", :primary => true
set :deploy_to, "/home/tyler/apps/deployed/#{application}"


#	Restart Passenger(mod_rails)
namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
after :deploy, "passenger:restart"

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

before "deploy:restart", :install_gems

task :install_gems do
  run "cd ~/apps/deployed/twitplot/current; sudo rake gems:install"
end
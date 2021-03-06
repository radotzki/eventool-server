set :application, 'eventool'
set :repo_url, 'git@github.com:radotzki/eventool_server.git'

# for deploy run the following:
# bundle exec cap production deploy
set :deploy_to, '/home/deploy/eventool'
# deploy to dev
# set :deploy_to, '/home/deploy/eventool_dev'

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
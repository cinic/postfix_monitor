# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@github.com:cinic/postfix_monitor.git'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.3'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/tornado/postfix_monitor'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w(config/database.yml)

# Default value for linked_dirs is []
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :foreman do
  desc 'Export the Procfile'
  task :export do
    on roles :app do
      execute "cd #{current_path} && (RAILS_ENV=#{fetch(:stage)} "\
      "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} "\
      "#{fetch(:rbenv_path)}/bin/rbenv sudo "\
      "$(#{fetch(:rbenv_path)}/bin/rbenv which bundle) exec foreman "\
      "export upstart /etc/init -a #{fetch(:application)} -u #{fetch(:user)}"\
      " -l #{shared_path}/log"
    end
  end

  desc 'Start the application services'
  task :start do
    on roles :app do
      execute :sudo, :service, fetch(:application), :start
    end
  end

  desc 'Stop the application services'
  task :stop do
    on roles :app do
      execute :sudo, :service, fetch(:application), :stop
    end
  end

  desc 'Restart the application services'
  task :restart do
    on roles :app do
      execute :sudo, :service, fetch(:application), :restart
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # after :publishing, :restart
  after :finishing, 'foreman:export'
  after :finishing, 'foreman:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end
end

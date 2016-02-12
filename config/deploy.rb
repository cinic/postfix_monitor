# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@github.com:cinic/postfix_monitor.git'
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

# Foreman configuration
# Set to :rbenv for rbenv sudo, :rvm for rvmsudo or true for normal sudo
set :foreman_use_sudo, false
set :foreman_roles, :all
set :foreman_template, 'upstart'
# set :foreman_export_path, -> { File.join(Dir.home, '.init') }
set :foreman_export_path, -> { File.join('/home', fetch(:user), '.init') }
set :foreman_options, -> { {
  app: fetch(:application),
  log: File.join(shared_path, 'log')
} }

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
    on roles fetch(:foreman_roles) do
      opts = fetch(:foreman_options, {})
      opts.merge!(host.properties.fetch(:foreman_options) || {})
      execute(:mkdir, '-p', opts[:log])

      within release_path do
        execute :rbenv, :foreman, 'export',
                fetch(:foreman_template),
                fetch(:foreman_export_path),
                opts.map { |opt, value| "--#{opt}=\"#{value}\"" }.join(' ')
      end
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

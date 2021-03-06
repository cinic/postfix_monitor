# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
job_type :rbenv_rake, %{ export PATH=~/.rbenv/shims:~/.rbenv/bin:/usr/bin:$PATH;
  eval "$(rbenv init -)"; cd :path && :environment_variable=:environment
  bundle exec rake :task --silent :output }
set :output, File.join(Whenever.path, 'log', 'cron.log')

# Many shortcuts available: :hour, :day, :month, :year, :reboot
every :day, at: '02:00am' do
  rbenv_rake 'parser:fetch'
end

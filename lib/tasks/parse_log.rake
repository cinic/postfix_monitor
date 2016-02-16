namespace :parser do
  desc 'Parse mail log file'
  task fetch: :environment do
    puts "Start parsing - #{Time.now}"
    parser = Parser::MailLog.new Rails.root.join('log', 'mail.log')
    parser.parse_log
    puts "End parsing - #{Time.now}"
  end
end

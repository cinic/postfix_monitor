class Message < ActiveRecord::Base
  has_many :recipients

  validates :postfix_queue_id, presence: true

  def decode_log
    parser = Parser::MailLog.new Rails.root.join('log', 'mail.log')
    parser.parse_log
  end
end

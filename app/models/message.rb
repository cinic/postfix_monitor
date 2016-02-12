class Message < ActiveRecord::Base
  has_many :recipients

  validates :postfix_queue_id, presence: true

  def decode_log
    parser = Parser::MailLog.new
    parser.parse_log
  end
end

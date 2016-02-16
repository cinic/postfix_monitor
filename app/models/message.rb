class Message < ActiveRecord::Base
  has_many :recipients

  validates :postfix_queue_id, presence: true
end

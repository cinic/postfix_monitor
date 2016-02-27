class Message < ActiveRecord::Base
  has_many :recipients

  validates :postfix_queue_id, presence: true

  def sended
    created_at - 1.day
  end
end

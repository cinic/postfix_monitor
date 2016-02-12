class Recipient < ActiveRecord::Base
  belongs_to :message

  validates :address, :status, presence: true
end

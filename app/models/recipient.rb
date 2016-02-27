class Recipient < ActiveRecord::Base
  belongs_to :message

  scope :delivered, -> { where(delivered: true).count }
  scope :delivered_list, -> { where(delivered: true) }
  scope :undelivered, -> { where(delivered: false).count }
  scope :undelivered_list, -> { where(delivered: false) }

  validates :address, :status, presence: true

end

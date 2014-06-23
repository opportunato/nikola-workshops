class Workshop < ActiveRecord::Base
  has_many :hosts, dependent: :destroy

  validates :title, :headline, :price, :start_date, :end_date, presence: true

  scope :for_admin, -> { includes('hosts').order('created_at DESC') }
end
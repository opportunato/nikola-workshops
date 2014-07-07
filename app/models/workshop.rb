class Workshop < ActiveRecord::Base
  has_many :hosts, dependent: :destroy
  has_many :videos, dependent: :destroy, class_name: "WorkshopVideo"
  has_many :images, dependent: :destroy, class_name: "WorkshopImage"

  validates :title, :headline, :price, :start_date, :end_date, presence: true

  scope :for_admin, -> { includes(:hosts, :images, :videos).order('start_date ASC') }
  scope :for_startpage, -> { where(is_published: true).includes(:hosts, :images, :videos).order('start_date ASC') }

  def passed?
    end_date > Date.current
  end

  def current?
    start_date > Date.current && end_date < Date.current
  end

  def has_hosts?
    hosts.size > 0
  end

  def host_image
    hosts.first.image_url if has_hosts?
  end

  def host_name
    hosts.first.name if has_hosts?
  end
end
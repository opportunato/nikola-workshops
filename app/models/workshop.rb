class Workshop < ActiveRecord::Base
  has_many :hosts, -> { order 'created_at ASC' }, as: :hostable, dependent: :destroy
  has_many :videos, -> { order 'created_at ASC' }, as: :videoable, dependent: :destroy, class_name: "WorkshopVideo"
  has_many :images, -> { order 'created_at ASC' }, as: :imageable, dependent: :destroy, class_name: "WorkshopImage"

  has_many :reports, -> { order 'created_at ASC' }

  validates :title, :headline, :price, :start_date, :end_date, presence: true

  scope :for_admin, -> { includes(:images, :videos, :hosts, reports: [:author, :images, :videos]).order('start_date ASC') }
  scope :for_startpage, -> { where(is_published: true).includes(:images, :videos, hosts: [:image]).order('start_date ASC') }

  extend FriendlyId
  friendly_id :title, use: :slugged

  def passed?
    end_date < Date.current
  end

  def current?
    start_date <= Date.current && end_date >= Date.current
  end

  def upcoming?
    start_date > Date.current
  end

  def has_hosts?
    hosts.size > 0
  end

  def has_reports?
    reports.published.size > 0
  end

  def host_image
    hosts.first.image_url if has_hosts?
  end

  def host_name
    hosts.first.name if has_hosts?
  end
end
class Report < ActiveRecord::Base
  belongs_to :workshop
  has_many :videos, -> { order 'created_at ASC' }, as: :videoable, dependent: :destroy, class_name: "WorkshopVideo"
  has_many :images, -> { order 'created_at ASC' }, as: :imageable, dependent: :destroy, class_name: "WorkshopImage"
  has_one :author, class_name: "Host", as: :hostable

  scope :published, -> { where(is_published: true).includes(:images, :videos, author: [:image]).order('created_at DESC') }

  before_create :assign_slug

  def has_author?
    !!self.author
  end

private

  def assign_slug
    previous_reports = Report.where(workshop_id: self.workshop_id)
                        .order('created_at DESC')

    self.number = previous_reports.size > 0 ? previous_reports.first.number += 1 : 1
    self.slug = "report-#{self.number}"
  end
end
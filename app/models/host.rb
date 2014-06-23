class Host < ActiveRecord::Base
  belongs_to :workshop

  validates :name, :description, :link, presence: true
end
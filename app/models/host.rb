class Host < ActiveRecord::Base
  belongs_to :workshop
  has_one :image, dependent: :destroy, class_name: "HostImage"

  validates :name, :description, :link, presence: true

  def image_url
    image.image.url(:small) if has_image?
  end

  def has_image?
    image.present?
  end
end
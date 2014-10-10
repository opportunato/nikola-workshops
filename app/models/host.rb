class Host < ActiveRecord::Base
  belongs_to :hostable, polymorphic: true
  has_one :image, dependent: :destroy, class_name: "HostImage"

  def image_url
    image.image.url(:small) if has_image?
  end

  def has_image?
    image.present?
  end
end
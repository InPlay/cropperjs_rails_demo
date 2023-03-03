class Product < ApplicationRecord
  has_one_attached :image
  has_one_attached :image_original

  has_one :image_cropable, as: :cropable, class_name: "CropperDatum"

  accepts_nested_attributes_for :image_cropable
end

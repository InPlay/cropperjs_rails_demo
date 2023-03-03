class CropperDatum < ApplicationRecord
  belongs_to :cropable, polymorphic: true

  attribute :background_color, :string, default: '#FFFFFF'
end

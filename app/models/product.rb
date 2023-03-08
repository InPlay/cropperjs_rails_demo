class Product < ApplicationRecord
  has_croppable :logo, height: 200, width: 300
  has_croppable :image, height: 300, width: 500
end

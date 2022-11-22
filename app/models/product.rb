class Product < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many_attached :images

end

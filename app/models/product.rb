class Product < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :order_items, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  

end

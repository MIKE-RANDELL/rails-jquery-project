class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :account

  def order_items_attributes=(order_item_attributes)
    binding.pry
  end
end

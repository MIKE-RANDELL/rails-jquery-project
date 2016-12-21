class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :account

  def order_items_attributes=(order_items_attributes)
    order_items_attributes.each do |i, order_item_attributes|
      self.order_items.build(order_item_attributes)
    end
  end
end

class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :account

  scope :pallets_out, -> { joins(:order_items).where('order_items.pallet_count = ?', 1) }


  def order_items_attributes=(order_items_attributes)
    order_items_attributes.each do |i, order_item_attributes|
      if check_for_inputs(order_item_attributes)
        order = self.order_items.build(order_item_attributes)
        if has_pallet(order.item)
          pallet_counter(order)
        end
      end
    end
  end

  def check_for_inputs(order_item_attributes)
    !order_item_attributes[:item_id].blank? || !order_item_attributes[:quantity].blank?
  end

  def has_pallet(item)
    item.with_pallet
  end

  def pallet_counter(order)
    order.pallet_count = order.quantity
    order.save
  end

  def self.order_items_with_pallets
    joins(:order_items).where("order_items.pallet_count > ?", 0)
  end

  def self.total_pallets(orders)
    total = 0

    orders.each do |order|
      order.order_items.each do |order_item|
        total += order_item.pallet_count
      end
    end
    
    total
  end
end

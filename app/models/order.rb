class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :account

  scope :orders_by_account, ->(account) { where('account_id = ?', account)}
  scope :orders_by_customer, ->(customer) { where('account_id = ?', customer.account)}
  scope :orders_with_pallets, -> { joins(:order_items).where('order_items.pallet_count = ?', 1) }
  #this returns the orders that include items that have pallets, note: remember, an order has many items

  def order_items_attributes=(order_items_attributes)
    order_items_attributes.each do |i, order_item_attributes|
      if check_for_inputs(order_item_attributes)
        order_item = self.order_items.build(order_item_attributes)
        if has_pallet(order_item.item)
          pallet_counter(order_item)
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

  def pallet_counter(order_item)
    order_item.pallet_count = order_item.quantity
    order_item.save
  end

  def self.total_pallets(orders) #going to use this in admin payment/return console
    total = 0
    orders.each do |order|
      order.order_items.each do |order_item|
        total += order_item.pallet_count
      end
    end
    total
  end
end

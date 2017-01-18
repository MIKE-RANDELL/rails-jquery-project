class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  scope :order_items_with_pallets, -> { where('pallet_count > ?', 0) }

  scope :item_totals, -> (item) {where('item_id == ?', item.id).sum('quantity')}
end

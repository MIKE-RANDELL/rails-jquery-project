class Item < ApplicationRecord
  #belongs_to :order
  has_many :order_items

  #scope :has_pallet, -> { where(with_pallet: true) }
end

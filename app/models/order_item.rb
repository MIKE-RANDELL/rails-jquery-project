class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  #validates :item_id, :presence => {:message => "You must choose"}
  #validates :quantity, :presence => {:message => "You must choose"}
  #validates :order_id, :presence => {:message => "You must choose"}
  #validates_presence_of :item_id, :message => "You must choose an item"
  #validates_presence_of :quantity, :message => "You must enter the quantity"
end

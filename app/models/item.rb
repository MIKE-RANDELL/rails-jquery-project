class Item < ApplicationRecord
  has_many :order_items

  validates_format_of :item_type, :with => /\A[A-Za-z\s]*\z/, :message => "input is invalid. No numbers or special characters.."

  #scope :item_total, ->(item) { where('account_id = ?', account)}
end

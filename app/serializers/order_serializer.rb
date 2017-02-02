class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :account_id
  has_many :order_items
  has_many :items
  belongs_to :account
end

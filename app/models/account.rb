class Account < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  #scope :account_orders, -> { joins(:orders).where("orders.account_id = ?", account.id) }

end

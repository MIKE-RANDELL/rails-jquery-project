class Account < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :notes
end

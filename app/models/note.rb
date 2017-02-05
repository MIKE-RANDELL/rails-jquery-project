class Note < ApplicationRecord
  belongs_to :account

  scope :notes_by_account, ->(account) { where('account_id = ?', account)}
end

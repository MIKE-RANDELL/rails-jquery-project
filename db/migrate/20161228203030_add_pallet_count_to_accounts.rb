class AddPalletCountToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :pallet_count, :integer, default: 0
  end
end

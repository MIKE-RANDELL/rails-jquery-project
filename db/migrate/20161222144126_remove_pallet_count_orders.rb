class RemovePalletCountOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :pallet_count
  end
end

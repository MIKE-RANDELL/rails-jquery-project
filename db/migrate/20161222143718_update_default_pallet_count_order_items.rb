class UpdateDefaultPalletCountOrderItems < ActiveRecord::Migration[5.0]
  def change
    change_column :order_items, :pallet_count, :integer, :default => 0
  end
end

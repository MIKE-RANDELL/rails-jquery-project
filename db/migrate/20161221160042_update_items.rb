class UpdateItems < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :with_pallet, :boolean, :default => false
  end
end

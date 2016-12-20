class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :item_type
      t.integer :price
      t.boolean :with_pallet

      t.timestamps
    end
  end
end

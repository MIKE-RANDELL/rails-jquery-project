class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :date
      t.integer :account_id
      
      t.timestamps
    end
  end
end

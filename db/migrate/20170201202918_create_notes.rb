class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :account_id
      t.string :content
      t.timestamps
    end
  end
end

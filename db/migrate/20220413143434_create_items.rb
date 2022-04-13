class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name,              null: false
      t.integer :price,                 null: false
      t.text :explanation,              null: false
      t.integer :postage_id,            null: false
      t.integer :category_id,           null: false
      t.integer :item_status_id,        null: false
      t.integer :prefecture_id,         null: false
      t.integer :item_send_id,          null: false
      t.references :user,               null: false, foreign_key: true 
    end
  end
end

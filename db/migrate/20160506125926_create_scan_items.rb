class CreateScanItems < ActiveRecord::Migration
  def change
    create_table :scan_items do |t|
      t.references :item, index: true, foreign_key: true
      t.references :shopping_cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

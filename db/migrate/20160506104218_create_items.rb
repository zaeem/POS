class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.float :unit_price
      t.float :volume_price
      t.integer :volume_qty
      t.references :terminal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

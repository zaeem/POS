class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :terminal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

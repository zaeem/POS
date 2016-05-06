class CreateTerminals < ActiveRecord::Migration
  def change
    create_table :terminals do |t|

      t.timestamps null: false
    end
  end
end

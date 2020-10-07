class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :type
      t.integer :quantity, default: 1
      t.decimal :price, precision: 10, scale: 2
      t.jsonb :parameters, default: {}

      t.timestamps
    end
  end
end

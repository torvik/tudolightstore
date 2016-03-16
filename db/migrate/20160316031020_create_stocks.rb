class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :products, index: true
      t.integer :quantity, :default => 1
      t.boolean :active

      t.timestamps null: false
    end
  end
end

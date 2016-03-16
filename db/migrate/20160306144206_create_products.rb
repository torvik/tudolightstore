class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :number
      t.text :description
      t.string :image_url
      t.decimal :price, :precision => 8, :scale => 2
      t.string :size
      t.boolean :active

      t.timestamps null: false
    end
  end
end

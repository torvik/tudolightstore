class RemoveEmailFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :email, :string
  end
end

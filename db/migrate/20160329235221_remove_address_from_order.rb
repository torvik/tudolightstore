class RemoveAddressFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :address, :string
  end
end

class RemovePhoneFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :phone, :string
  end
end

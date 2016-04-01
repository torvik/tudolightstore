class Customer < ActiveRecord::Base
  has_many :orders

  validates :name, :phone, :email, :address, :presence => true



end

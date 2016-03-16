class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy


  PAYMENT_TYPES = [ "Dinheiro" , "Débito" , "Crédito", "Vale", "Transferencia" ]
  STATUS = [ "Solicitado", "Em atendimento", "Em estoque", "Pronto para entrega", "Entregue", "Cancelado" ]

  validates :name, :address, :phone, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  validates :status, :inclusion => STATUS

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end


end

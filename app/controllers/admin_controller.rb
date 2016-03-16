class AdminController < ApplicationController
  def index
     @total_orders = Order.count
     @totalproducts = Product.count
     @totalitens = LineItem.count

     @order = Order.all
     @line_items = LineItem.where("line_items.order_id= ?", @order_id)

     @total_pedido = 0
     @line_items.each do |line_items|
      @ordernumber = @order.id
      @total_pedido += line_items.total_price
     end



  end


     #@products = Product.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 10).order(name: :asc, tamanho: :asc)
     #@totalproducts = Product.where(:user_id => current_user.id).count
     #@totalcusto = Product.where(:user_id => current_user.id).sum(:price)
     #@totalprecovenda = Product.where(:user_id => current_user.id).sum(:valuev)


end

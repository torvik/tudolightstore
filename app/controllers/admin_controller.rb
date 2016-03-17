class AdminController < ApplicationController
  def index
     @total_orders = Order.count
     @totalproducts = Product.count
     @totalitens = LineItem.count
  end

     #@products = Product.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 10).order(name: :asc, tamanho: :asc)
     #@totalproducts = Product.where(:user_id => current_user.id).count
     #@totalcusto = Product.where(:user_id => current_user.id).sum(:price)
     #@totalprecovenda = Product.where(:user_id => current_user.id).sum(:valuev)


end

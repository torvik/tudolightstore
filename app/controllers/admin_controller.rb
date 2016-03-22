class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
     @orders = Order.order("created_at DESC").limit(5)
     @total_orders = Order.count
     @totalproducts = Product.count
     @totalitens = LineItem.sum(:quantity)
     @totalstock = Stock.all.sum(:quantity)

     @totalvendido = Order.sum(:total_price)
     @valormediovenda = Order.average(:total_price)
     @maiorvenda = Order.maximum(:total_price)
     @menorvenda = Order.minimum(:total_price)

      @total_order_solicitado = Order.where(status: "Solicitado").count
      @total_order_atendimento = Order.where(status: "Em atendimento").count
      @total_order_estoque = Order.where(status: "Em estoque").count
      @total_order_pronta_entrega = Order.where(status: "Pronto para entrega").count
      @total_order_entregue = Order.where(status: "Entregue").count
      @total_order_cancelado = Order.where(status: "Cancelado").count

      #Pegar as ordens do DIA
      @today_in = (Time.zone.now.to_date).beginning_of_day.utc
      @today_fim = (Time.zone.now.to_date).end_of_day.utc
      @total_today_orders = Order.where(created_at: @today_in..@today_fim).count

  end

        #@totalvendido = Sale.where(:user_id => current_user.id).sum(:amount)
        #@valormediovenda = Sale.where(:user_id => current_user.id).average(:amount)
        #@maiorvenda = Sale.where(:user_id => current_user.id).maximum(:amount)
        #@menorvenda = Sale.where(:user_id => current_user.id).minimum(:amount)

     #@products = Product.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 10).order(name: :asc, tamanho: :asc)
     #@totalproducts = Product.where(:user_id => current_user.id).count
     #@totalcusto = Product.where(:user_id => current_user.id).sum(:price)
     #@totalprecovenda = Product.where(:user_id => current_user.id).sum(:valuev)


end

class AdminController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!

  def index
     @orders = Order.order("created_at DESC").limit(5)
     @total_orders = Order.count
     @totalproducts = Product.count
     @totalitens = LineItem.sum(:quantity)
     @totalstock = Stock.all.sum(:quantity)
     @totalcustomers = Customer.count


     @totalvendido = Order.sum(:total_price)
     @valormediovenda = Order.average(:total_price)
     @maiorvenda = Order.maximum(:total_price)
     @menorvenda = Order.minimum(:total_price)

     @order_maior_venda = Order.where(total_price: @maiorvenda)
     @order_menor_venda = Order.where(total_price: @menorvenda)

     @order_maior_venda.each do |order|
      @customer_id = order.customer_id
      @customer_maior_venda = Customer.where(id: @customer_id)
      #@customer_mais_pedidos = Customer.joins(:orders).count(@customer_id)
      #@customer_mais_pedidos = Order.where(customer_id: @customer.id).count
     end

     @order_menor_venda.each do |order|
      @customer_id = order.customer_id
      @customer_menor_venda = Customer.where(id: @customer_id)
     end


     #@posts_per_user_count = Post.joins(:user).group(:user).order('count_all DESC').limit(10).count

     @orders_per_customer_count = Order.joins(:customer).group(:customer).order('count_all DESC').limit(10).count

     @customer_count_maior = Order.joins(:customer).group(:customer).order('count_all DESC').limit(1).count

     #@customer_mais_pedidos_id = Customer.select(' count(orders.id) AS orders_count').joins(:orders).group('orders.customer_id').order('orders_count DESC')
     #@customer_mais_pedidos = Customer.where(id: @customer_mais_pedidos_id)


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

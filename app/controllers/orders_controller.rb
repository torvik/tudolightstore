class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 10).order('id DESC')
    @customers = Customer.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @line_item = LineItem.all
    @customers = Customer.all

  end

  # GET /orders/new
  def new
    @customers = Customer.all.order(name: :asc)
    if current_cart.line_items.empty?
     redirect_to store_index_path, :notice => "Your cart is empty"
     return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end

  end

  # GET /orders/1/edit
  def edit
    @customers = Customer.all
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save

        #pesquisar os itens da ordem e salvar a quantidade no estoque
        order = @order
        @total_pedido = 0

        @line_items = LineItem.where("line_items.order_id= ?", order.id)

        @line_items.each do |line_items|
          @stock = Stock.find_by_products_id(line_items.product_id)
          @stock.quantity -= line_items.quantity
          @stock.save
          @total_pedido += line_items.total_price
         end
          @order.total_price = @total_pedido
          @order.save


        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(store_index_path, :notice => 'Thank you for your order.') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        #pesquisar os itens da ordem e salvar a quantidade no estoque
        order = @order
        @total_pedido = 0

        @line_items = LineItem.where("line_items.order_id= ?", order.id)

        @line_items.each do |line_items|
          #@stock = Stock.find_by_id(line_items.product_id)
          #@stock.quantity -= line_items.quantity
          #@stock.save
          @total_pedido += line_items.total_price
         end
          @order.total_price = @total_pedido
          @order.save

        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy

    #pesquisar os itens da ordem e salvar a quantidade no estoque
      order = @order
      @line_items = LineItem.where("line_items.order_id= ?", order.id)

      @line_items.each do |line_items|
        @stock = Stock.find_by_products_id(line_items.product_id)
        @stock.quantity += line_items.quantity
        @stock.save
       end
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit( :delivery_date, :pay_type, :status, :total_price, :customer_id)
    end
end

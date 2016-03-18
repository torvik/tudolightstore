class StoreController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all.order(number: :asc)
    @cart = current_cart
    @stock = Stock.all

  end
end

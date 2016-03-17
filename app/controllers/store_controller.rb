class StoreController < ApplicationController
  def index
    @products = Product.all.order(number: :asc)
    @cart = current_cart
    @stock = Stock.all

  end
end

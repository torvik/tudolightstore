class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
    @stock = Stock.all

  end
end

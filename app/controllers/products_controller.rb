class ProductsController < ApplicationController


  def index
    if params[:query].present? || !params[:query].nil?
      @products = Kroger::KrogerProduct.search(params[:query])
    else
      @products = Kroger::KrogerProduct.search("pizza")
    end

    console
  end

end

class ProductsController < ApplicationController
require 'json'

  def index

    # @products = products

    @products = Kroger::KrogerProduct.search("yogurt")

    console
  end

  private

  # def search(query = [])
  #   @products = where(query)
  # end

  private


end

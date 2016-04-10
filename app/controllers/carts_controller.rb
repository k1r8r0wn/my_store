class CartsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_cart, only: [:add_item, :remove_item]

  def show
    @items = Cart.where(user: current_user).first.items
  end

  def add_item
    @cart.items << @item = Item.find(params[:cart][:item_id])
    flash[:success] = "#{@item.name} added to cart"
    redirect_to :show
  end

  def remove_item
    @cart.items.delete(@item = Item.find(params[:cart][:item_id]))
    flash[:success] = "#{@item.name} removed to cart"
    redirect_to :show
  end

  private

  def find_cart
    @cart = Cart.where(user: current_user).first
  end

end

class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  # /items/1 GET
  def show
    unless @item = Item.where(id: params[:id]).first
      render text: 'Page not found', status: 404
    end
  end

  # /items/new GET
  def new
    @item = Item.new
  end

  # /items/edit/1 GET
  def edit; end

  # /items POST
  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  # /items/1 PUT, PATCH
  def update; end

  # /items/1 DELETE
  def destroy; end

  private

  def item_params
    params.require(:item).permit(:price, :name, :real, :weight, :description)
  end

end

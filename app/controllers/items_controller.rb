class ItemsController < ApplicationController

  def index
    @items = Item.all
    render text: @items.map {|i| "#{i.name}: #{i.price}"}.join('<br/>')
  end

  def create
    @item = Item.create(item_params)
    render text: "#{@item.id}: #{@item.name} (#{!@item.new_record?})"
  end

  private

  def item_params
    params.require(:item).permit(:price, :name, :real, :weight, :description)
  end

end

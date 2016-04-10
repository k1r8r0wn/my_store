class ItemsController < ApplicationController

  before_action :find_item,      only: [:show, :edit, :update, :destroy, :upvote, :crop_image]
  before_action :check_if_admin, only: [:edit, :update, :new, :create, :destroy]

  # /items GET
  def index
    @items = Item
    @items = @items.where('price >= ?', params[:price_from])       if params[:price_from]
    @items = @items.where('created_at >= ?', 1.day.ago)            if params[:today]
    @items = @items.where('votes_count >= ?', params[:votes_from]) if params[:votes_from]
    @items = @items.order('votes_count DESC', 'price')
  end

  # /items/expensive GET
  def expensive
    @items = Item.where('price > 1000')
    render :index
  end

  # /items/:id GET
  def show
    unless @item
      render text: 'Page not found', status: 404
    end
    @item.views.increment
  end

  # /items/new GET
  def new
    @item = Item.new
  end

  # /items/:id/edit GET
  def edit; end

  # /items POST
  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to crop_image_item_path(@item)
    else
      flash.now[:error] = 'You made mistakes in your form. Please correct them.'
      render :new
    end
  end

  # /items/:id PUT, PATCH
  def update
    @item.update_attributes(item_params)
    if @item.errors.empty?
      redirect_to crop_image_item_path(@item)
    else
      flash.now[:error] = 'You made mistakes in your form. Please correct them.'
      render :edit
    end
  end

  # /items/:id DELETE
  def destroy
    @item.destroy
    flash[:success] = 'Your item is successfully deleted!'
    redirect_to items_path
  end

  # /items/:id/upvote
  def upvote
    @item.increment!(:votes_count)
    redirect_to items_path
  end

  def crop_image
    if request.put?
      @item.crop_image!(params[:item][:image_crop_data])
      flash[:success] = 'Your item is successfully updated!'
      redirect_to item_path(@item)
    end
  end

  private

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end

  def item_params
    params.require(:item).permit(:price, :name, :real, :weight, :description, :image)
  end

end

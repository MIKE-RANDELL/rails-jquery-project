class ItemsController < ApplicationController
  def new
    @item = Item.new
    authorize @item
    render :partial => 'items/item_form', locals: {item: @item}
  end

  def create
    @item = Item.create(params_check)
    redirect_to items_path
  end

  def index
    @items = Item.all
    authorize @items
  end

  def edit
    @item = Item.find(params[:id])
    render :partial => 'items/item_form', locals: {item: @item}
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params_check)
      redirect_to items_path
    else #this is where I can use ActiveRecord errors object?
      redirect_to edit_item_path(@item)
      flash[:error] = "You must enter valid details"
    end
  end

  private

  def params_check
    params.require(:item).permit(:item_type, :price, :with_pallet)
  end
end

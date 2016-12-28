class ItemsController < ApplicationController
  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(params_check)
    if @item.save
      redirect_to items_path
    else
      render :partial => 'items/item_form', locals: {item: @item}
    end
  end

  def index
    @items = Item.all
    authorize @items
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params_check)
      redirect_to items_path
    else
      render :partial => 'items/item_form', locals: {item: @item}
    end
  end

  private

  def params_check
    params.require(:item).permit(:item_type, :price, :with_pallet)
  end
end

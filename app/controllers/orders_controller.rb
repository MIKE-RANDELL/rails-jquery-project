class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @user = current_user
    @account = Account.find_or_create_by(user_id: @user.id)
    @order = Order.create(params_check)
    @account.orders << @order
  end

  private
  def params_check
    params.require(:order).permit(:date, :order_items_attributes => [:order_id, :item_id, :quantity])
  end
end

class OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.order_items.build
    @order.order_items.build
    @order.order_items.build
  end

  def create
    @user = set_user
    @account = Account.find_or_create_by(user_id: @user.id)
    order = @account.orders.create(params_check)
    update_account_balance(@account, order)
    
    redirect_to user_account_path(@user.id)
  end

  private

  def params_check
    params.require(:order).permit(:date, :order_items_attributes => [:order_id, :item_id, :quantity])
  end

  def set_user
    if current_user.try(:admin?)
      User.find(params[:user][:id])
    else
      current_user
    end
  end

  def update_account_balance(account, order)
    tax = 1.06
    order.order_items.each do |order_item|
      account.balance += order_item.quantity * order_item.item.price.to_f * tax
    end
    account.save
  end
end

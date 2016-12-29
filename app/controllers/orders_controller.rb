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
    update_account_pallet_count(@account, order)

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
    pallet_price = 6.00
    order.order_items.each do |order_item|
      if order_item.pallet_count > 0
        account.balance += (order_item.quantity * order_item.item.price.to_f * tax) + (order_item.pallet_count * pallet_price)
      else
        account.balance += order_item.quantity * order_item.item.price.to_f * tax
      end
    end
    account.save
  end

  def update_account_pallet_count(account, order)
    order.order_items.each do |order_item|
      if order_item.pallet_count > 0
        account.pallet_count += order_item.pallet_count
      end
    end
    account.save
  end
end

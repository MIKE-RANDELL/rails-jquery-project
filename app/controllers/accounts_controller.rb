class AccountsController < ApplicationController
  def orders
    @user = current_user
    @orders = @user.account.orders
  end
end

class AccountsController < ApplicationController
  def orders
    @user = User.find(params[:id])
    @orders = @user.account.orders

    @account = @user.account
    authorize @account
  end

  def index
    @accounts = Account.all
    authorize @accounts
  end
end

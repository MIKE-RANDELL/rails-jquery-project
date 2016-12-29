class AccountsController < ApplicationController
  before_action :find_account

  def index
    @accounts = Account.all
    authorize @accounts
  end

  def orders
    @orders = @account.orders #@orders = Order.orders_by_account(@account) #use of AR scope method = SLOW
    authorize @account
  end

  def payment
    authorize @account
  end

  def create_payment
    payment = BigDecimal.new(params[:debit])
    @account.balance -= payment
    @account.save

    redirect_to user_account_path(@account.user_id)
  end

  def pallets

  end

  def return_pallets
    amount = params[:return_amt].to_i
    @account.pallet_count -= amount
    @account.balance -= amount * 6
    @account.save

    redirect_to user_account_path(@account.user_id)
  end

  private

  def find_account
    @account = Account.find_by(:user_id => params[:id])
  end
end

class AccountsController < ApplicationController
  before_action :find_account
  include AccountsHelper

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
    make_payment(@account, payment)

    redirect_to user_account_path(@account.user_id)
  end

  def pallets

  end

  def return_pallets
    amount = params[:return_amt].to_i
    pallet_return(@account, amount)

    redirect_to user_account_path(@account.user_id)
  end

  #def books
  #end

  private

  def find_account
    @account = Account.find_by(:user_id => params[:id])
  end
end

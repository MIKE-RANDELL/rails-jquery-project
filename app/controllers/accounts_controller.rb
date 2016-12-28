class AccountsController < ApplicationController
  before_action :find_account

  def orders
    #binding.pry
    #@account = Account.find_by(:user_id => params[:id])
    @orders = @account.orders
    #@orders = Order.orders_by_account(@account) #use of AR scope method = SLOW

    authorize @account
  end

  def payment
    #@account = Account.find_by(:user_id => params[:id]) #uses nested route :id

    authorize @account
  end

  def create_payment
    #@account = Account.find_by(:user_id => params[:id])
    payment = BigDecimal.new(params[:debit])
    @account.balance -= payment
    @account.save

    redirect_to user_account_path(@account.user_id)
  end

  def index
    @accounts = Account.all
    authorize @accounts
  end

  private

  def find_account
    @account = Account.find_by(:user_id => params[:id])
  end
end

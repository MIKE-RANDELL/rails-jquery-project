class AccountsController < ApplicationController
  before_action :find_account
  include AccountsHelper

  def index
    @accounts = Account.all
    authorize @accounts
  end

  def orders
    @note = Note.new
    @current_note = @account.notes.last
    #@current_note_date = note_date(@current_note.created_at)
    @orders = @account.orders
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

  def books
    @items = Item.all
    @book_printout_array = item_setter(@items)
  end

  def books_orders
    @accounts = Account.all
    @orders = Order.all
    render json: @orders
  end

  #def api_account
  #  @account = Account.find(params[:id])
  #  render json: @account
  #end

  private

  def item_setter(items)
    current_book = []
    items.each do |item|
      current_book << "#{item.item_type}: " + OrderItem.item_totals(item).to_s
    end
    return current_book
  end

  def find_account
    #@account = Account.find_by(params[:id])
    @account = Account.find_by(:user_id => params[:id])
  end
end

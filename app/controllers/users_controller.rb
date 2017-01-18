class UsersController < ApplicationController
  def home
    @item = Item.new
    @account = Account.new
  end
end

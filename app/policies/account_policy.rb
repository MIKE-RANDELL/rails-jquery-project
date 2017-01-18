class AccountPolicy < ApplicationPolicy
  def index?
    user.try(:admin?)
  end

  def orders?
    user.try(:admin?) || record.try(:user) == user
  end

  def payment?
    user.try(:admin?)
  end

  def pallets?
    user.try(:admin?)
  end

  def books?
    user.try(:admin?) #to be implemented
  end
end

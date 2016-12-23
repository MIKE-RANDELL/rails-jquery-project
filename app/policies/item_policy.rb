class ItemPolicy < ApplicationPolicy
  def new?
    user.try(:admin?)
  end

  def index?
    user.try(:admin?)
  end
end

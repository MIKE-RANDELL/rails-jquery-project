class NotePolicy < ApplicationPolicy
  def api_create?
    user.try(:admin?)
  end
end

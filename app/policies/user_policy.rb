class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    true
    user.admin? || record == user
  end

  def create?
    true
  end

  def destroy?
    true
  end
end

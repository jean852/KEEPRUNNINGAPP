class NilClassPolicy < ApplicationPolicy
  def edit?
    true
  end

  def show?
    true
  end

  def update?
    true
  end
end

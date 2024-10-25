class PostPolicy < ApplicationPolicy
  def update?
    user.present? && (record.user == user || user.author?)
  end

  def destroy?
    user.present? && record.user == user
  end

  def create?
    user.present?
  end

  def show?
    true
  end
end

# frozen_string_literal: true

class AddressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create? && user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    update? && user.admin?
  end

  def destroy?
    user.admin?
  end
end

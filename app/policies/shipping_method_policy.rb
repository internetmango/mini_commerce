# frozen_string_literal: true

class ShippingMethodPolicy < ApplicationPolicy
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

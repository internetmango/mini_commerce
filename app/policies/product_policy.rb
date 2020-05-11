# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
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

  def search?
    true
  end

  def import_csv?
    user.admin?
  end

  def export_csv?
    user.admin?
  end

  def process_csv?
    user.admin?
  end
end

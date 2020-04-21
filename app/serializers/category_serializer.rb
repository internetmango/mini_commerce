# frozen_string_literal: true

class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :created_at, :updated_at
end

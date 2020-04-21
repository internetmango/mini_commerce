# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :admin, :name, :created_at, :updated_at, :authentication_token
end

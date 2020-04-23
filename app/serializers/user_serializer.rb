# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :mobile, :admin, :created_at,
             :last_sign_in_at, :confirmed_at, :authentication_token
end

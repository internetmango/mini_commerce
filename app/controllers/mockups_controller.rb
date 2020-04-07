# frozen_string_literal: true

class MockupsController < ApplicationController
  skip_before_action :authenticate_user!

  def index; end

  def search; end

  def category; end

  def cart; end
end

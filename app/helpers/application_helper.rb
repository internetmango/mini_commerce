# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-danger'
    else 'alert alert-info'
    end
  end
end

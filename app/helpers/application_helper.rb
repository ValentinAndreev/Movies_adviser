# frozen_string_literal: true

module ApplicationHelper
  def present(model)
    return if model.blank?
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
    presenter
  end
end

# frozen_string_literal: true

# Presenter for review
class ReviewPresenter < SimpleDelegator
  def review_item
    text = model.text
    @review_item ||= text.size > 1000 ? text[0..1000] + '...' : text
  end

  private

  def model
    __getobj__
  end
end

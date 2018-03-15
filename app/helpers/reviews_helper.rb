# frozen_string_literal: true

# :reek:UtilityFunction { exclude: [ review_item ] }

module ReviewsHelper
  def review_item(review)
    text = review.text
    text.size > 1000 ? text[0..1000] + '...' : text
  end
end

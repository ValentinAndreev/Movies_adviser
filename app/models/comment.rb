# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :body, presence: true
end

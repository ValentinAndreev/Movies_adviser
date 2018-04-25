# frozen_string_literal: true

# Vote model
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :movie
end

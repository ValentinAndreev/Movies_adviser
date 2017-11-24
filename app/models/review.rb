class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :comments, as: :commentable, dependent: :destroy
  validates :text, presence: true
end

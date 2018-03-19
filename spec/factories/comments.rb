# frozen_string_literal: true

FactoryGirl.define do
  factory :comment do
    username 'username'
    body 'Comment'
    commentable_type 'Review'
    commentable_id nil
  end
end

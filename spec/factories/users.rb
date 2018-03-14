# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    username 'Name'
    email 'mail@mail.com'
    password 'password'
  end
end

# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    username 'Name'
    email 'mail@mail.com'
    password 'password'
  end

  factory :another_user, class: User do
    username 'Another_Name'
    email 'another_mail@mail.com'
    password 'another_password'
  end
end

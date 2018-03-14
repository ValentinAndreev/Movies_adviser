# frozen_string_literal: true
# :reek:Attribute { exclude: [ :email, :username, :role ]

class GuestUser < User
  attr_accessor :email, :username, :role
end

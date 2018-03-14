# frozen_string_literal: true

module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || CurrentUserConcern.guest_user
  end

  def self.guest_user
    GuestUser.new(email: 'guest@example.com', username: 'guest', role: 'guest')
  end
end

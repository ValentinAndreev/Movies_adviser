class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :votes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :username,  presence: true
  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def recommended
    votes.where(value: 1).pluck(:movie_id)
  end

  def not_recommended
    votes.where(value: -1).pluck(:movie_id)
  end
end

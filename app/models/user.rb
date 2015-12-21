class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook]

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_one :info, dependent: :destroy
  has_many :invitations, foreign_key: "to_user_id", dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, foreign_key: "user_id"

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  def to_param
    username
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.username = auth.info.name.downcase.split.join('_')
    end
  end
end

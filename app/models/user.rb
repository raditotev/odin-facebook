class User < ActiveRecord::Base

  before_save :create_username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook]

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_one :info, dependent: :destroy

  has_many :sent_invitations, class_name: "Invitation",
                  foreign_key: "from_user_id", dependent: :destroy
  has_many :invites, through: :sent_invitations, source: "to_user"
  has_many :received_invitations, class_name: "Invitation",
                  foreign_key: "to_user_id", dependent: :destroy
  has_many :invitations, through: :received_invitations, source: "from_user"

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: "friend"

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :notifications, dependent: :destroy

  def to_param
    username
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.skip_confirmation!
    end
  end

  def create_username
    self.username = self.name.downcase.split.join('_') if self.username.nil?
  end
end

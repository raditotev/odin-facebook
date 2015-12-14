class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_one :info, dependent: :destroy
  has_many :invitations, foreign_key: "to_user_id", dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, foreign_key: "user_id"

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
end

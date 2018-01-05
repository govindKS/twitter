class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile 
  has_many :followings
  # belongs_to :following_user, class_name: 'Following', foreign_key: 'id'
  has_many :tweets
  has_many :comments
end

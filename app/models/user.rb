class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :cart
  has_many :orders
  has_many :comments

  validates_uniqueness_of :email

end

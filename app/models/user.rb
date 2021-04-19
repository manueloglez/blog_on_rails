class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments

  validates :name, presence: true
  validates(
    :email, 
    uniqueness: true,
    presence: true,
    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  )
end

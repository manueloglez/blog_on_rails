class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates(:title, presence: true, uniqueness: true)

  # To read an array of error messages after failling validation:
  # record.errors.full_messages
  validates(
    :body, 
    presence: { message: "post must include a body" },
    length: { minimum: 50 },
  )
end

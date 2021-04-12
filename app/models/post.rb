class Post < ApplicationRecord
  validates(:title, presence: true, uniqueness: true)

  # To read an array of error messages after failling validation:
  # record.errors.full_messages
  validates(
    :body, 
    presence: { message: "post must include a body" },
    length: { minimum: 50 },
  )
end

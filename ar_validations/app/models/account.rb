class Account < ApplicationRecord

  validate :password_should_have_one_number
  def password_should_have_one_number
    p "here!"
    # if password.count("0-9") > 0
    #   p password
    #   errors.add(:password, "must contain a number")
    end



  # all entries must exist
  validates :username, :password, :email, presence: true

  # all usernames must be unique
  validates :username, uniqueness: true

  # # all passwords must be unique
  # validates :password, uniqueness: true
  #
  # # all usernames must be 5 characters long
  # validates :username, length: { minimum: 5 }
  #
  # all passwords must be 6 characters long
  validates :password, length: { minimum: 6 }



end

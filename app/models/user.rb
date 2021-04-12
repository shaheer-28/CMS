class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  PASSWORD_LENGTH = 11
  ROLES = {user: 'user', admin: 'admin'}
  enum role: ROLES

  validates :phone_number, length: { is: PASSWORD_LENGTH }
  validate :password_lower_case
  validate :password_uppercase
  validate :password_special_char

  def password_uppercase
    return if !!password.match(/\p{Upper}/)

    errors.add :password, 'must contain at least 1 uppercase '
  end

  def password_lower_case
    return if !!password.match(/\p{Lower}/)

    errors.add :password, 'must contain at least 1 lowercase '
  end

  def password_special_char
    special = "! \" ? $ % ^ & ()."
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    return if password =~ regex
    
    errors.add :password, 'must contain special character'
  end
end

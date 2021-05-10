class User < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
  has_many :camps_registrations, dependent: :destroy
  has_many :camps, through: :camps_registrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validations
  
  PHONE_NUMBER_LENGTH = 11
  ROLES = {user: 'user', admin: 'admin'}
  enum role: ROLES

  scope :by_role, ->(role) { where(role: role) }

  validates :phone_number, length: { is: PHONE_NUMBER_LENGTH }
  validate :password_lower_case, unless: :skip_password_validations
  validate :password_uppercase, unless: :skip_password_validations
  validate :password_special_char, unless: :skip_password_validations

  def skip_password_validations
    @skip_password_validations ||= false
  end

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

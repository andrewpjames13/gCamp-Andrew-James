class User < ActiveRecord::Base
  def full_name
    "#{first_name} #{last_name}"
  end
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: :true
  validates_confirmation_of :password
  validates_presence_of :password_confirmation, message: 'should match confirmation'

  has_secure_password
end

class User < ActiveRecord::Base

  def full_name
    "#{first_name} #{last_name}"
  end


  has_many :memberships
  has_many :projects, through: :memberships

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: :true

  has_secure_password
end

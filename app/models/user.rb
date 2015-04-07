class User < ActiveRecord::Base

  def full_name
    "#{first_name} #{last_name}"
  end


  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :comments, dependent: :destroy
  has_many :tasks, through: :comments

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: :true

  has_secure_password
end

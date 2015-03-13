class Membership < ActiveRecord::Base

  validates :user_id, presence: :true, uniqueness: {scope: :project_id, message: "has already been added to this project."}

  belongs_to :user
  belongs_to :project

  enum role: {member: 1, owner: 2}

end

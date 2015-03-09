class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  enum role: {member: 1, owner: 2}

end

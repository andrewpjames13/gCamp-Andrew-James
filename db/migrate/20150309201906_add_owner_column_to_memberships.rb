class AddOwnerColumnToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :owner, :boolean
  end
end

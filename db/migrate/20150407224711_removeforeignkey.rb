class Removeforeignkey < ActiveRecord::Migration
  def change
    remove_foreign_key "comments", "users"

  end
end

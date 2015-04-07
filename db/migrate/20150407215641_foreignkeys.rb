class Foreignkeys < ActiveRecord::Migration
  def change
    add_foreign_key "comments", "tasks"
    add_foreign_key "comments", "users"

  end
end

class AddUserId < ActiveRecord::Migration
    def up
    add_column :statuses, :user_id, :integer
    change_column_null :statuses, :user_id, false
  end
  def down
    remove_column :statuses, :user_id, :integer
  end
end

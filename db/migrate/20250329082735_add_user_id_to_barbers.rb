class AddUserIdToBarbers < ActiveRecord::Migration[8.0]
  def change
    add_column :barbers, :user_id, :integer
  end
end

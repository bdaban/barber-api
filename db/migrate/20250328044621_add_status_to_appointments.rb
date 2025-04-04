class AddStatusToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_column :appointments, :status, :string
  end
end

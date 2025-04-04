class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :barber, null: false, foreign_key: true
      t.date :date
      t.string :time

      t.timestamps
    end
  end
end

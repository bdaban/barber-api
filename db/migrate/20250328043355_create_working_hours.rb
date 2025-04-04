class CreateWorkingHours < ActiveRecord::Migration[8.0]
  def change
    create_table :working_hours do |t|
      t.references :barber, null: false, foreign_key: true
      t.string :day
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end

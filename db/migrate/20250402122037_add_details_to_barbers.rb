class AddDetailsToBarbers < ActiveRecord::Migration[8.0]
  def change
    add_column :barbers, :address, :string
    add_column :barbers, :phone, :string
  end
end

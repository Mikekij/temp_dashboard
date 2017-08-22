class CreateTemperatures < ActiveRecord::Migration[5.1]
  def change
    create_table :temperatures do |t|
      t.integer :thermometer_id
      t.float :temperature_c

      t.timestamps
    end
  end
end

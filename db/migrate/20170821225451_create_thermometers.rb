class CreateThermometers < ActiveRecord::Migration[5.1]
  def change
    create_table :thermometers do |t|
      t.string :name
      t.string :serial
      t.string :location

      t.timestamps
    end
  end
end

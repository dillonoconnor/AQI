class CreateMeasurements < ActiveRecord::Migration[6.1]
  def change
    create_table :measurements do |t|
      t.date :measurement_date
      t.integer :pm25_latest
      t.integer :pm25_avg
      t.integer :pm25_min
      t.integer :pm25_max
      t.references :station, null: false, foreign_key: true

      t.timestamps
    end
  end
end

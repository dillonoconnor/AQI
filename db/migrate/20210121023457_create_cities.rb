class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :aqi
      t.datetime :aqi_date
      t.integer :pm25_forecast1
      t.date :pm25_forecast1_date
      t.integer :pm25_forecast2
      t.date :pm25_forecast2_date
      t.integer :pm25_forecast3
      t.date :pm25_forecast3_date
      t.integer :pm25_forecast4
      t.date :pm25_forecast4_date
      t.integer :pm25_forecast5
      t.date :pm25_forecast5_date
      t.integer :pm25_forecast6
      t.date :pm25_forecast6_date
      t.integer :pm25_forecast7
      t.date :pm25_forecast7_date
      t.integer :pm25_forecast8
      t.date :pm25_forecast8_date
      t.integer :pm25_forecast9
      t.date :pm25_forecast9_date

      t.timestamps
    end
  end
end

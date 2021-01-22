class RemoveColumnsFromCities < ActiveRecord::Migration[6.1]
  def change
    remove_columns :cities, :pm25_forecast1, :pm25_forecast1_date, :pm25_forecast2,
                   :pm25_forecast2_date, :pm25_forecast3, :pm25_forecast3_date,
                   :pm25_forecast4, :pm25_forecast4_date, :pm25_forecast5,
                   :pm25_forecast5_date, :pm25_forecast6, :pm25_forecast6_date,
                   :pm25_forecast7, :pm25_forecast7_date, :pm25_forecast8, 
                   :pm25_forecast8_date, :pm25_forecast9, :pm25_forecast9_date
    
  end
end

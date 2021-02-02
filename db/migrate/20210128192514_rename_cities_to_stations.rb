class RenameCitiesToStations < ActiveRecord::Migration[6.1]
  def change
    rename_table :cities, :stations
    rename_column :measurements, :city_id, :station_id
  end
end

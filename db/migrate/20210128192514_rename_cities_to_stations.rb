class RenameCitiesToStations < ActiveRecord::Migration[6.1]
  def change
    rename_table :cities, :stations
  end
end

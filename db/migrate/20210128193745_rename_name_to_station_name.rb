class RenameNameToStationName < ActiveRecord::Migration[6.1]
  def change
    rename_column :stations, :name, :station_name
  end
end

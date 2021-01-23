class RemovePm25LatestFromMeasurements < ActiveRecord::Migration[6.1]
  def change
    remove_column :measurements, :pm25_latest
  end
end

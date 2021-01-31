class AddStateToStations < ActiveRecord::Migration[6.1]
  def change
    add_reference :stations, :state, null: false, foreign_key: true
  end
end

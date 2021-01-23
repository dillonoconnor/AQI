class AddSlugToCities < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :slug, :string
  end
end

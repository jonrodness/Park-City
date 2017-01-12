class AddImageUrlToParks < ActiveRecord::Migration
  def change
    add_column :parks, :image_url, :text
  end
end

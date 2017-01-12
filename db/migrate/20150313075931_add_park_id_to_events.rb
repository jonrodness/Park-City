class AddParkIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :park_id, :integer
  end
end

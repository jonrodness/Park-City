class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :spots
      t.date :date, :null => false

      t.timestamps null: false
    end
  end
end

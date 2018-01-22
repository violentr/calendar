class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :number, null: false
      t.string :name
      t.string :size, default: 'single', null: false
      t.timestamps null: false
    end
  end
end

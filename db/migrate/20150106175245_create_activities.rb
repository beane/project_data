class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :activities, :name, unique: true
  end
end

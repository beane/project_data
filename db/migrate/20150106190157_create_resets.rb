class CreateResets < ActiveRecord::Migration
  def change
    create_table :resets do |t|
      t.datetime   :datetime, null: false, index: true
      t.references :activity, null: false, index: true
      t.timestamps            null: false
    end

    add_foreign_key :resets, :activities
  end
end

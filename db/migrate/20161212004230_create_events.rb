class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :type
      t.references :user, index: true, foreign_key: true
      t.string :unique_event_id

      t.timestamps
    end
  end
end

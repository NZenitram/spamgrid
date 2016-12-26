class ChangeEventsTableTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :type, :column
  end
end

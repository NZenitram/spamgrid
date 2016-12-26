class FixColumnNameOnEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :column, :category
  end
end

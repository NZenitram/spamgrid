class ChangeUserColumneName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :email, :email_address
  end
end

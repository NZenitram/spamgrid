class AddUserIdToUploads < ActiveRecord::Migration[5.0]
  def change
    add_reference :uploads, :user, foreign_key: true
  end
end

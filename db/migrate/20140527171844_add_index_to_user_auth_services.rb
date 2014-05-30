class AddIndexToUserAuthServices < ActiveRecord::Migration
  def change
    add_index :user_auth_services, :uid, :unique => true
  end
end

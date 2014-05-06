class AddIdToUserAuthServices < ActiveRecord::Migration
  def change
    add_column :user_auth_services, :id, :primary_key
  end
end

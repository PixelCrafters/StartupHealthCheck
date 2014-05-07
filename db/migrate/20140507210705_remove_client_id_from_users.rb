class RemoveClientIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :auth0_client_id
  end
end

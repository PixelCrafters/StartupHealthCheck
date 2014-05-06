class AddAuth0ClientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth0_client_id, :string
  end
end

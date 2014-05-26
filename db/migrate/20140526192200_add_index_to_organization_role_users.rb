class AddIndexToOrganizationRoleUsers < ActiveRecord::Migration
  def change
    add_index :organization_role_users, [ :organization_id, :role_id, :user_id ], :unique => true, name: 'organization_role_users_index'
  end
end

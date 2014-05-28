class AddIdToOrganizationRoleUsers < ActiveRecord::Migration
  def change
    add_column :organization_role_users, :id, :primary_key
  end
end

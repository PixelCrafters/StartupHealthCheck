class RenameOrganizationRoleUsers < ActiveRecord::Migration
  def change
    rename_table :organization_role_users, :organization_user_roles
  end
end

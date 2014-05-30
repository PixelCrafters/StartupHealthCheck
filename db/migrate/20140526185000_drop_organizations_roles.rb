class DropOrganizationsRoles < ActiveRecord::Migration
  def change
    drop_table :organizations_roles
  end
end

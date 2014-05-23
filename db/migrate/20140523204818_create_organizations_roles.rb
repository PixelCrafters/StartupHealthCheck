class CreateOrganizationsRoles < ActiveRecord::Migration
  def change
    create_table :organizations_roles do |t|
      t.integer :role_id
      t.integer :organization_id
      t.integer :user_id
    end
  end
end

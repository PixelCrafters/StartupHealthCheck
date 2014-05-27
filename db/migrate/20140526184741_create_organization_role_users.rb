class CreateOrganizationRoleUsers < ActiveRecord::Migration
  def change
    create_table :organization_role_users, id: false do |t|
      t.integer :organization_id
      t.integer :role_id
      t.integer :user_id
    end
  end
end

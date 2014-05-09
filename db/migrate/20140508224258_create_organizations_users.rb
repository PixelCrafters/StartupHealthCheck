class CreateOrganizationsUsers < ActiveRecord::Migration
  def change
    create_table :organizations_users, id: false do |t|
      t.references :organization
      t.references :user
    end
  end
end

class CreateOrganizationsTypes < ActiveRecord::Migration
  def change
    create_table :organizations_types, :id => false do |t|
      t.references :organization
      t.references :type
    end
    add_index :organizations_types, [:organization_id, :type_id], :unique => true
  end
end

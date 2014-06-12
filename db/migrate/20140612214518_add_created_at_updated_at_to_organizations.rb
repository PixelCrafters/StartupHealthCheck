class AddCreatedAtUpdatedAtToOrganizations < ActiveRecord::Migration
  def change
    change_table :organizations do |t|
      t.timestamps
    end
  end
end

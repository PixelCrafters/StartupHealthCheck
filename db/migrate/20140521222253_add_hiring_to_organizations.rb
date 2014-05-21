class AddHiringToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :hiring, :boolean, default: false
  end
end

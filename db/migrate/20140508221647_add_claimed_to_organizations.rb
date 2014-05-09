class AddClaimedToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :claimed, :boolean, default: false
  end
end

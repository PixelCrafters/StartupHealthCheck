class AddImageToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :image, :string
  end
end

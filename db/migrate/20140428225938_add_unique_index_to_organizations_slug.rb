class AddUniqueIndexToOrganizationsSlug < ActiveRecord::Migration
  def change
    add_index :organizations, :slug, unique: true
  end
end

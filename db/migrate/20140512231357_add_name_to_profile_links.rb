class AddNameToProfileLinks < ActiveRecord::Migration
  def change
    add_column :profile_links, :name, :string
  end
end

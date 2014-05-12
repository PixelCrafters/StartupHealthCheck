class CreateProfileLinks < ActiveRecord::Migration
  def change
    create_table :profile_links do |t|
      t.string :url
      t.integer :organization_id
      t.string :image
    end
  end
end

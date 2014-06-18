class AddStartupGenomeFieldsAndClaimedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :startup_genome_slug, :string
    add_column :users, :startup_genome_image, :string
    add_column :users, :startup_genome_url, :string
    add_column :users, :claimed, :boolean, default: false
  end
end

class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :headline, :string
    add_column :organizations, :description, :text
    add_column :organizations, :hiring_url, :string
    add_column :organizations, :active, :boolean
    add_column :organizations, :approved, :boolean
    add_column :organizations, :startup_genome_slug, :string
    add_column :organizations, :url, :string
    add_column :organizations, :founded, :timestamp
    add_column :organizations, :startup_genome_id, :integer
  end
end

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :organization_id
      t.string :address1
      t.string :address2
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude
    end
  end
end

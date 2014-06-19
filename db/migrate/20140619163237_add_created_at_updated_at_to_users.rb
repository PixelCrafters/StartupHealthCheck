class AddCreatedAtUpdatedAtToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.timestamps
    end
  end
end

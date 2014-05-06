class CreateUserAuthServices < ActiveRecord::Migration
  def change
    create_table :user_auth_services, :id => false do |t|
      t.integer :user_id
      t.string :uid
      t.string :type
    end
  end
end

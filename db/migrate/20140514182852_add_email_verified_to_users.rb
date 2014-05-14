class AddEmailVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_verified, :boolean, default: false
  end
end

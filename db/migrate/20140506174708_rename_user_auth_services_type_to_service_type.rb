class RenameUserAuthServicesTypeToServiceType < ActiveRecord::Migration
  def change
    rename_column :user_auth_services, :type, :service_type
  end
end

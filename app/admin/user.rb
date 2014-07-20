ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  config.filters = false

  sidebar 'Organizations Claimed by this User', :only => :show do
    table_for Organization.joins(:users).where(:admin_id => user.id) do |t|
      t.column("Org Name") { |organization| organization.name }
    end
  end

  index do
    actions
    column :name, :min_width => "100px"
    column :tags do |user|
      table_for user.tags.order('name ASC') do
        column do |tag|
          link_to tag.name, [ :admin, type ]
        end
      end
    end
        
    column :claimed
  end
  
end

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

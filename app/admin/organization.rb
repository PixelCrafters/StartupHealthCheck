ActiveAdmin.register Organization do

  
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

  permit_params :name, :headline, :description, :founded, :active, :claimed, :hiring, :hiring_url

  # AA doesn't handle has_many well, so don't use those
  filter :types
  filter :active
  filter :claimed
  filter :hiring

  # need to find by ID
  before_filter do
    Organization.class_eval do
      def to_param
        id.to_s
      end
    end
  end

  index do
    actions
    column :name, :min_width => "100px"
    column "Headline", :min_width => "250px" do |organization|
          truncate(organization.headline, omision: "…", length: 100)
        end

    # TODO: not working correctly
    column :types do |organization|
      table_for organization.types.order('name ASC') do
        column do |type|
          link_to type.name, [ :admin, type ]
        end
      end
    end
        
    column :claimed
    column "Claimed By" do |organization|
      # TODO: look up admin id and join on user table to get name / admin link to user
    end

    column :active
    column :founded
    column :hiring
  end

  show do
    attributes_table do
      row :name
      row :headline
      row :description
      table_for organization.types.order('name ASC') do
        column "Types" do |type|
          link_to type.name, [ :admin, type ]
        end
      end
      row :founded
      row :active

      row :claimed
      row "Claimed By"
      # TODO: same look up admin id as above

      row :hiring
    end
  end

  form do |f|
    f.inputs "Add/Edit Organization" do
      f.input :name
      f.input :headline
      f.input :description
      f.input :types
      f.input :active
      f.input :hiring
      f.input :founded 

    end
    f.actions
  end


end

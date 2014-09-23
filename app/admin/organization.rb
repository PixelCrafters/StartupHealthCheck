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

  permit_params :name, :headline, :description, :founded, :active, :claimed, :hiring, :hiring_url, :admin_id

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

    column "Types" do |organization|
      raw(organization.types.order('name ASC').map{ |type| link_to type.name, [ :admin, type ]}.join(", "))
    end
        
    column "Claimed By" do |organization|
      if organization.claimed && !organization.admin_id.nil?
        usr = User.find(organization.admin_id)
        link_to usr.name, admin_user_path(organization.admin_id)  
      else
        "None"
      end
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
      row :claimed
      row :active
      row :admin_id
      
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
      f.input :admin_id, :label => 'Claimed by', :as => :select, :collection => User.order(:name).all.map{|u| ["#{u.name}", u.id]}
    end
    f.actions
  end


end

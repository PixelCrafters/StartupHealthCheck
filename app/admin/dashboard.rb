ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    
    panel "Recent Organizations" do
      table_for Organization.order('id desc').limit(10) do
        column "Name" do |organization|
          link_to organization.name, admin_organization_path(organization.id)  
        end
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
    end

    panel "Recent Users" do
      table_for User.order('id desc').limit(10) do
        column "Name" do |user|
          link_to user.name, admin_user_path(user.id)  
        end
        column "Tags" do |user|
          raw(user.tags.order('name ASC').map{ |tag| tag.name }.join(", "))
        end
        column :claimed                  
      end
    end
      
  end # content
end

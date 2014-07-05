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

  # AA doesn't handle has_many well
  remove_filter :organization_user_roles
  remove_filter :addresses
  remove_filter :profile_links
  remove_filter :roles
  remove_filter :users
  remove_filter :activities
  remove_filter :taggings
  remove_filter :base_tags
  remove_filter :tag_taggings
  remove_filter :slug
  remove_filter :startup_genome_slug
  remove_filter :hiring_url
  remove_filter :url
  remove_filter :image
  remove_filter :organizations_users
  remove_filter :organizations_types

end

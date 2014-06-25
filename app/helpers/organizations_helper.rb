module OrganizationsHelper
  def status
    @organization.active ? "active" : "not active"
  end

  def display_address
    address = ""
    if @organization.main_address.address1
      address = "#{@organization.main_address.address1}<br />"
    end
    if @organization.main_address.address2
      address += "#{@organization.main_address.address2}<br />"
    else
      address += "#{Rails.application.secrets.location_name}<br />"
    end
    if @organization.main_address.zip
      address += "#{@organization.main_address.zip}<br />"
    end
    address.html_safe
  end
end

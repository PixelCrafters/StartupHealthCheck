module OrganizationsHelper
  def status
    @organization.active ? "active" : "not active"
  end
end

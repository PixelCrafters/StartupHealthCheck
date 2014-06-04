class Organization::Search
  include Service

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if params[:type]
      params[:type][:ids].shift
      if !params[:query].empty? && params[:type][:ids].any?
        Organization.search params[:query], where: {type_ids: params[:type][:ids]}
      elsif !params[:query].empty? && !params[:type][:ids].any?
         Organization.search params[:query]
      elsif params[:query].empty? && params[:type][:ids].any?
        Organization.search "*", where: {type_ids: params[:type][:ids]}
      end
    else
      Organization.search params[:query]
    end
  end
end

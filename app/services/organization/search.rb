class Organization::Search
  include Service

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    @results = Organization.search params[:query]
  end
end


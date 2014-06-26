class Search
  include Service

  attr_reader :params, :search_type, :query, :tags, :types

  def initialize(params, search_type=nil)
    @params = params
    @search_type = search_type
    @query = params[:query] || "*"
    @tags = params[:tags] || nil
    @types = params[:types] || nil
  end

  def call
    if search_type == "organization"
      organizations
    elsif search_type == "user"
      users
    else
      all_results
    end
  end

  private

  def all_results
    organizations + users
  end

  def organizations
    Organization.search(query, conditions).results
  end

  def users
    User.search(query, conditions).results
  end

  def conditions
    if tags && types
      {where: {tag_names: {all: tags}, type_ids: {all: types}}}
    elsif tags
      {where: {tag_names: {all: tags}}}
    elsif types
      {where: {type_ids: {all: types}}}
    else
      {}
    end
  end
end

class Organization::Search
  include Service

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    shift_params
    get_results
  end

  private

  def shift_params
    params[:type][:ids].shift
    params[:tag][:names].shift
  end

  def get_results
    types = params[:type][:ids]
    tags = params[:tag][:names]
    keyword = params[:query]

    any_types = params[:type][:ids].any?
    any_tags = params[:tag][:names].any?
    any_keyword = params[:query].present?

    case
    when any_keyword && any_types && any_tags
      Organization.search keyword, where: {type_ids: types, tag_names: tags}
    when any_keyword && any_types
      Organization.search keyword, where: {type_ids: types}
    when any_keyword && any_tags
      Organization.search keyword, where: {tag_names: tags}
    when any_types && any_tags
      Organization.search "*", where: {type_ids: types, tag_names: tags}
    when any_keyword
      Organization.search(keyword).results + User.search(keyword).results
    when any_types
      Organization.search "*", where: {type_ids: types}
    when any_tags
      Organization.search "*", where: {tag_names: tags}
    else 
      Organization.search "*"
    end
  end
end

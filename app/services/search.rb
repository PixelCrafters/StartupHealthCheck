class Search
  include Service

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    shift_params if params[:type] || params[:tag]
    get_results
  end

  private

  def shift_params
    params[:type][:ids].shift unless params[:type].nil? || params[:type][:ids][0] != ""
    params[:tag][:names].shift unless params[:tag].nil? || params[:tag][:names][0] != ""
  end

  def get_results
    params[:type] && params[:type][:ids].any? ? types = params[:type][:ids] : types = false
    params[:tag] && params[:tag][:names].any? ? tags = params[:tag][:names] : tags = false
    !params[:query].empty? ? keyword = params[:query] : keyword = false unless params[:query].nil?

    if keyword && types && tags
      Organization.search(keyword, where: {type_ids: types, tag_names: tags}).results + User.search(keyword, where: {tag_names: tags}).results
    elsif keyword && types
      Organization.search keyword, where: {type_ids: types}
    elsif keyword && tags
      Organization.search(keyword, where: {tag_names: tags}) + User.search(keyword, where: {tag_names: tags}).results
    elsif types && tags
      Organization.search("*", where: {type_ids: types, tag_names: tags}).results + User.search("*", where: {tag_names: tags}).results
    elsif keyword
      Organization.search(keyword).results + User.search(keyword).results
    elsif types
      Organization.search "*", where: {type_ids: types}
    elsif tags
      Organization.search("*", where: {tag_names: tags}).results + User.search("*", where: {tag_names: tags}).results
    else 
      Organization.search("*").results + User.search("*").results
    end
  end
end

class SearchController < ApplicationController
  def index
    @results = Search.call(prepare_search_params)
    @results = Kaminari.paginate_array(@results).page(params[:page])
  end

  def search_organizations
    @results = Search.call(prepare_search_params, "organization")
    @results = Kaminari.paginate_array(@results).page(params[:page])
  end

  def search_users
    @results = Search.call(prepare_search_params, "user")
    @results = Kaminari.paginate_array(@results).page(params[:page])
  end

  private

  def prepare_search_params
    prepare_types if params[:types].present?
    prepare_tags if params[:tags].present?
    prepare_query if params[:query].present?
    params
  end

  def prepare_query
    params[:query] = nil if params[:query].empty?
  end

  def prepare_tags
    params[:tags][:names].shift if params[:tags][:names].first.empty?
    params[:tags] = params[:tags][:names].empty? ? nil : params[:tags][:names]
  end

  def prepare_types
    params[:types][:ids].shift if params[:types][:ids].first.empty?
    params[:types] = params[:types][:ids].empty? ? nil : params[:types][:ids]
  end
end

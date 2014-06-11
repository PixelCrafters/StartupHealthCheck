class SearchController < ApplicationController
  def index
    if params[:query].present? || params[:type].present? || params[:tag].present?
      @results = Search.call(params)
      @results = Kaminari.paginate_array(@results).page(params[:page])
    end
  end
end

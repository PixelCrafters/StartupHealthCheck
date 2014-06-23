class Search
  include Service

  attr_reader :params, :keyword, :tags, :types

  def initialize(params)
    @params = params
    shift_params
    @keyword = params["query"].nil? ? "*" : params["query"]
    if params["tag"].present?
      @tags = params["tag"]["names"].empty? ? nil : params["tag"]["names"]
    elsif params["types"].present?
      @types = params["type"]["ids"].empty? ? nil : params["type"]["ids"]
    else
      @tags = nil
      @types = nil
    end
  end

  def call
    get_results
  end

  private

  def shift_params
    if params["tag"]
      params["tag"]["names"].shift if params["tag"]["names"].first.empty?
    elsif params["type"]
      params["type"]["ids"].shift if params["type"]["ids"].first.empty?
    end
  end

  def get_results
    Organization.search(keyword, where: {type_ids: types, tag_names: tags}).results + User.search(keyword, where: {tag_names: tags}).results
  end
end

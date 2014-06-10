class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order('created_at desc').page
  end
end

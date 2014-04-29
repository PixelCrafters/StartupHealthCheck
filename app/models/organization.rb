class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  searchkick

  def search_data
    as_json only: [:name]
  end
end

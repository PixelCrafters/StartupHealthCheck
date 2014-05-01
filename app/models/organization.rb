class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  searchkick

  has_many :addresses

  def search_data
    as_json only: [:name]
  end

  # temporary addition. will be replaced by 'main_address' once we acquire what the main address is from a person
  def main_address
    addresses.first
  end
end

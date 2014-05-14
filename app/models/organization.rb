class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  searchkick
  acts_as_taggable

  has_many :addresses
  has_many :profile_links
  has_and_belongs_to_many :users

  def search_data
    as_json only: [:name]
  end

  # temporary addition. will be replaced by 'main_address' once we acquire what the main address is from a person
  def main_address
    addresses.first
  end
end

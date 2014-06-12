class Organization < ActiveRecord::Base
  include PublicActivity::Common

  extend FriendlyId
  friendly_id :name, use: :slugged

  searchkick
  acts_as_taggable

  has_many :organization_user_roles
  has_many :addresses
  has_many :profile_links
  has_many :roles
  has_and_belongs_to_many :users
  has_and_belongs_to_many :types

  def search_data
    {
      name: name,
      type_ids: types.map(&:id),
      tag_names: tags.map(&:name)
    }
  end

  # temporary addition. will be replaced by 'main_address' once we acquire what the main address is from a person
  def main_address
    addresses.first
  end

  def updated_last_24_hours?
    updated_at > Time.now - 24.hours
  end

  def created_last_24_hours?
    created_at > Time.now - 24.hours
  end
end

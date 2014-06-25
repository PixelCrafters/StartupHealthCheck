class ProfileLink < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :organization

  before_save :add_url_protocol

  protected

  def add_url_protocol
    unless self.url[/\Ahttps?:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end

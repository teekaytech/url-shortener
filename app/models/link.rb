class Link < ApplicationRecord
  validates_presence_of :original
  validates_uniqueness_of :code

  validate :url_format, on: :create

  def url_format
    url = URI.parse(original || '')
    errors.add(:original, 'URL format is invalid') if !url.is_a?(URI::HTTP) || url.host.nil?
  end
end

class Link < ApplicationRecord
  validates_presence_of :original, message: 'URL cannot be blank'
  validates_uniqueness_of :code
  validates_length_of :code, is: 7

  validate :url_format, on: :create

  def url_format
    url = URI.parse(original || '')
    errors.add(:original, 'URL format is invalid') if !url.is_a?(URI::HTTP) || url.host.nil?
  end
end

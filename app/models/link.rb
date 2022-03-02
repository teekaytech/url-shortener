class Link < ApplicationRecord
  validates_presence_of :original
  validates_uniqueness_of :code

end

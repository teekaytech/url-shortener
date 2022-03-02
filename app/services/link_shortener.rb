class LinkShortener
  attr_reader :url, :link_class

  def initialize(link = Link, url:)
    @url = url
    @link_class = link
  end

  def shorten
    @link_class.create(original: @url, code: unique_code)
  end

  private

  def generate_code
    SecureRandom.uuid[0..6]
  end

  def unique_code
    loop do
      new_code = generate_code
      return new_code unless @link_class.exists?(code: new_code)
    end
  end
end

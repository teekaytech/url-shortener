class LinksController < ApplicationController
  before_action :all_links, only: %i[index create destroy]

  def index
    @link = Link.new
  end

  def create
    shortener = LinkShortener.new(url: link_params[:original])
    @link = shortener.shorten
  end

  def show
    puts 'SHOW'
  end

  def destroy
    puts 'DELETE'
  end

  private

  def link_params
    params.require(:link).permit(:original, :code, :clicks)
  end

  def all_links
    @links = Link.all.limit(10)
  end
end

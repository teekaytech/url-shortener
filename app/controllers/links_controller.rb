class LinksController < ApplicationController
  before_action :set_links, only: %i[index create destroy]
  before_action :set_link, only: %i[show destroy]

  def index
    @link = Link.new
  end

  def create
    shortener = LinkShortener.new(url: link_params[:original])
    @link = shortener.shorten
  end

  def show
    @link.update(clicks: @link.clicks.to_i + 1)
    redirect_to @link.original
  end

  def destroy
    @link.destroy
    redirect_to root_path
  end

  private

  def link_params
    params.require(:link).permit(:original, :code, :clicks)
  end

  def set_link
    query = params[:code].present? ? params[:code] : params[:id]
    @link = Link.find_by(code: query)

    render file: "#{Rails.root}/public/404.html", layout: false unless @link.present?
  end

  def set_links
    @links = Link.order('id desc').limit(10)
  end
end

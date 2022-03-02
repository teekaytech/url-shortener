class LinksController < ApplicationController
  before_action :links, only: [:create, :destroy]

  def index
    @link = Link.new
  end

  def create
  end

  def show
  end

  def destroy
  end
  
  private
  
  def link_params
    params.require(:link).permit(:original, :code, :clicks)
  end
  
  def links
    Link.all.order('id desc')
  end
end

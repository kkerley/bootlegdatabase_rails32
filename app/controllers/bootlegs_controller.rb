class BootlegsController < ApplicationController
  before_filter :require_admin
  
  def index
    @bootlegs = Bootleg.all
  end

  def edit
    @bootleg = Bootleg.find(params[:id])
  end
  
  def show
    @bootleg = Bootleg.find(params[:id])
    @bootleg.revert_to(params[:version].to_i) if params[:version]
  end

end

class BuildingsController < ApplicationController

  def index
    if 'latest' == params[:keyword]
      @q = Building.latest.ransack(params[:q])
      @buildings = @q.result(distinct: true)
    elsif 'old' == params[:keyword]
      @q = Building.old.ransack(params[:q])
      @buildings = @q.result(distinct: true)
    elsif 'high' == params[:keyword]
      @q = Building.all.includes(:rooms).order("rooms.rent desc").ransack(params[:q])
      @buildings = @q.result(distinct: true)
    elsif 'row' == params[:keyword]
      @q = Building.all.includes(:rooms).order("rooms.rent").ransack(params[:q])
      @buildings = @q.result(distinct: true)
    else
      @q = Building.ransack(params[:q])
      @buildings = @q.result(distinct: true)
    end
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def create
    building = Building.new(building_params)
    building.save!
    redirect_to buildings_url, notice: "物件#{building.name}を登録しました。"
  end

  def destroy
    building = Building.find(params[:id])
    building.destroy
    redirect_to buildings_url, notice: "物件#{building.name}を削除しました"
  end

  private
  def building_params
    params.require(:building).permit(:name, :zipcode, :prefectures, :address, :image)
  end
end

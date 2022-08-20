class BuildingsController < ApplicationController

  def index
    if 'latest' == params[:keyword]
      @q = Building.latest.ransack(params[:q])
    elsif 'old' == params[:keyword]
      @q = Building.old.ransack(params[:q])
    elsif 'high' == params[:keyword]
      @q = Building.all.includes(:rooms).order("rooms.rent desc").ransack(params[:q])
    elsif 'row' == params[:keyword]
      @q = Building.all.includes(:rooms).order("rooms.rent").ransack(params[:q])
    else
      @q = Building.latest.ransack(params[:q])
    end
    @buildings = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def create
    @building = current_user.buildings.new(building_params)

    if @building.save
      redirect_to buildings_url, notice: "物件#{@building.name}を登録しました。"
    else
      render :new
    end
  end

  def destroy
    building = Building.find(params[:id])
    building.destroy
    redirect_to buildings_url, notice: "物件#{building.name}を削除しました"
  end

  private
  def building_params
    params.require(:building).permit(:name, :zipcode, :prefectures, :image, :transportation, :completion, :floor_height, :building_type, :balcony_type, :structure_type, :city, :town_name)
  end
end

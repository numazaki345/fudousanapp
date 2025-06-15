class BuildingsController < ApplicationController
  def index
    @q = filter_buildings
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

  def edit
    @building = Building.find(params[:id])
  end

  def update
    building = Building.find(params[:id])
    building.update!(building_params)
    redirect_to buildings_url, notice: "物件#{building.name}を更新しました。"
  end

  def destroy
    building = Building.find(params[:id])
    building.destroy
    redirect_to buildings_url, notice: "物件#{building.name}を削除しました"
  end

  private

  def buildings
    @buildings ||= Building.all.preload(:rooms)
  end

  def filter_buildings
    case params[:keyword]
    when 'latest'
      buildings.latest.ransack(params[:q])
    when 'old'
      buildings.old.ransack(params[:q])
    when 'short'
      buildings.short.ransack(params[:q])
    when 'long'
      buildings.long.ransack(params[:q])
    when 'high'
      buildings.order('rooms.rent desc').ransack(params[:q])
    when 'low'
      buildings.order('rooms.rent').ransack(params[:q])
    else
      buildings.latest.ransack(params[:q])
    end
  end

  def building_params
    params
      .require(:building)
      .permit(
        :name,
        :zipcode,
        :prefectures,
        :image,
        :station,
        :station_minute,
        :completion,
        :floor_height,
        :building_type,
        :balcony_type,
        :structure_type,
        :city,
        :town_name
      )
  end
end

class BuildingsController < ApplicationController
  def index
    @buildings = Building.all.includes(:rooms)
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
      params.require(:building).permit(:name, :zipcode, :prefectures, :address)
    end
end

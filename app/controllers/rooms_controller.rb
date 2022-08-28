class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:show]

  def show
    @room = Room.find(params[:id])
    @images = @room.images
    @building = @room.building
  end

  def create
    @building = Building.find(params[:building_id])
    @room = @building.rooms.new(room_params)
    if @room.save
      redirect_to buildings_url, notice: "部屋を登録しました。"
    else
      render 'buildings/show'
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to buildings_path, notice: "部屋を削除しました"
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @building = @room.building
    @room.update!(room_params)
    redirect_to buildings_url, notice: "物件#{@building.name}を更新しました。"
  end

  private
  def room_params
    params.require(:room).permit(:rent, :square, :room_number, :floor, :madori, images: [])
  end
end

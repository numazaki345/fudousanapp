class BuildingsController < ApplicationController
  PERMIT_PARAMS = %i[
    name
    image
    station
    station_minute
    completion
    floor_height
    building_type
    balcony_type
    structure_type
    zipcode
    prefectures
    city
    town_name
  ].freeze
  private_constant :PERMIT_PARAMS

  def index
    @q = filter_buildings.ransack(params[:q])
    @buildings = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def create
    @form = BuildForm.new(params: create_params)

    if @form.save
      redirect_to buildings_url, notice: "物件#{@form.name}を登録しました。"
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
    @buildings ||= Building.all.preload(:rooms, :address)
  end

  def filter_buildings
    case params[:keyword]
    when 'old' then buildings.old
    when 'short' then buildings.short
    when 'long' then buildings.long
    when 'high' then buildings.order('rooms.rent desc')
    when 'low' then buildings.order('rooms.rent')
    else
      buildings.latest
    end
  end

  def create_params
    snake_case_params
      .require(:building)
      .permit(PERMIT_PARAMS)
      .reverse_merge(user_id: current_user.id)
  end

  class BuildForm
    include ActiveModel::Validations

    def initialize(params:)
      @params = params
    end

    def save
      ActiveRecord::Base.transaction do
        building.save
        address.save
      end

      errors.empty?
    end

    def name = building.name

    private

    attr_reader :params

    def building
      @building ||= Building.new(
        **params.except(
          :zipcode,
          :prefectures,
          :city,
          :town_name
        )
      )
    end

    def address
      Address.new(
        building:,
        zipcode: params[:zipcode],
        prefectures: params[:prefectures],
        city: params[:city],
        town_name: params[:town_name],
      )
    end
  end
end

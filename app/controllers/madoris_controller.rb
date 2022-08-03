class MadorisController < ApplicationController
  def index
    @madoris = Madori.all
  end

  def show
    @madori = Madori.find(params[:id])
  end

  def new
    @madori = Madori.new
  end

  def create
    madori = Madori.new(madori_params)
    madori.save!
    redirect_to madoris_url, notice: "物件を登録しました。"
  end

  def destroy
    madori = Madori.find(params[:id])
    madori.destroy
    redirect_to madoris_url, notice: "物件を削除しました"
  end

  private

    def madori_params
      params.require(:madori).permit(:rent, :square)
    end
end

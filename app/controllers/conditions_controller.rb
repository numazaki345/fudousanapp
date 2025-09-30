class ConditionsController < ApplicationController
  skip_before_action :authenticate_user!

  PERMIT_PARAMS = [
    :area,
    :rent_high,
    :rent_low,
    :row,
    :completion,
    :minute,
    {
      rent_option: [],
      madori: [],
      building: []
    }
  ].freeze

  def show
    @condition = condition
    @client = @condition.client
  end

  def create
    @client = Client.find(params[:client_id])
    @condition = @client.build_condition(condition_params)

    if @condition.save
      if current_user
        redirect_to clients_url, notice: 'お客様情報を登録しました'
      else
        redirect_to @condition, notice: "お客様情報を登録しました。
        ３営業日以内にお客様のメールアドレス宛に弊社から物件のご提案をいたします。"
      end
    else
      render 'clients/show'
    end
  end

  def edit = @condition = condition

  def update
    condition.update!(condition_params)
    if current_user
      redirect_to clients_url, notice: 'お客様情報を更新しました'
    else
      redirect_to condition, notice: 'お客様情報を更新しました'
    end
  end

  private

  def condition
    @condition ||= Condition.find(params[:id])
  end

  def condition_params
    params.require(:condition).permit(PERMIT_PARAMS)
  end
end

class ConditionsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @condition = Condition.find(params[:id])
    @client = @condition.client
  end

  def create
    @client = Client.find(params[:client_id])
    @condition = @client.build_condition(condition_params)

    if @condition.save
      if current_user
        redirect_to clients_url
      else
        redirect_to complete_client_conditions_path
      end
    else
      render 'clients/show'
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    condition = Condition.find(params[:id])
    condition.update!(condition_params)
    redirect_to clients_url, notice: "お客様情報を更新しました"
  end

  private
  def condition_params
    params.require(:condition).permit(:area, :rent_high, :rent_low, :row, :completion, :minute, rent_option:[], madori:[], building:[])
  end
end

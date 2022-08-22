class ClientsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_root, except: [:new, :create, :confirm, :complete]
  def index
    @clients = Client.all.page(params[:page]).per(10)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if params[:back] || !@client.save #戻るボタンを押したときまたは、@clientが保存されなかったらnewアクションを実行
      render :new and return
    end
    if current_user
      redirect_to complete_clients_path, notice: "#{@client.name}を登録しました。"
    else
      redirect_to complete_clients_path
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def confirm
    @client = Client.new(client_params)
    if @client.invalid? #入力項目に空のものがあれば入力画面に遷移
      render :new
    end
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    redirect_to clients_url, notice: "#{client.name}を削除しました"
  end

  private
  def client_params
    params.require(:client).permit(:name, :birth, :gender, :rent_high, :rent_low, :conditions, :completion, :minute, rent_option:[], madori:[], building:[])
  end

  def redirect_root
    redirect_to new_client_path unless user_signed_in?
  end
end

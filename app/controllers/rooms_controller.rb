class RoomsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :create, :delete]
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(rooms_params)
    @room.user_id = current_user.id
    @room.room_image = "default-image.png" if @room.room_image.blank?
    if @room.save
      flash[:notice] = "施設を登録しました"
      redirect_to home_index_path
    else
      render "new"
    end
  end
  
  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end

  def update
    @user = current_user
    @room = Room.find(params[:id])
    if @room.update(rooms_params)
      flash[:notice] = "変更を保存しました"
      redirect_to home_index_path
    else
      flash[:alert] = "不具合が発生したのでデータは保存されませんでした"
      redirect_to home_index_path
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to show_room_user_path(current_user.id)
  end

  def detail
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def reservation
    @user= current_user
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def search
    @rooms = Room.search(params[:keyword])
    @rooms_count = @rooms.count
  end

  def area_search
    @rooms = Room.areasearch(params[:area])
    @rooms_count = @rooms.count
  end

  private

  def rooms_params
    params.require(:room).permit(:name, :detail, :price, :address, :introduction, :room_image)
  end
end

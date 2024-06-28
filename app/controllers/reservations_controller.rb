class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room_id
  def index
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    if @reservation.invalid?
      render "new"
    end
  end

  def create
    @reservation = @room.reservations.new(reservation_params)

    if params[:back] || !@reservation.save
      render "new"
      return
    else
      flash[:notice] = "予約が完了しました"
      redirect_to home_index_path
    end
  end

  private

  def set_room_id
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:checkin, :checkout, :people, :user_id, :room_id)
  end
end
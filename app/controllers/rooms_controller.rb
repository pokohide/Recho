class RoomsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_room, only: %i[edit update destroy]

  def index
    @rooms = Room.page(params[:page])
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)

    binding.pry
    @room.excute_iframe!
    if @room.save
      redirect_to room_path(@room), notice: 'ルームを作成しました.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to edit_room_path(@room), notice: 'ルームを更新しました.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to account_path, notice: "「#{@room.title}」を削除しました."
  end

  private

  def set_room
    @room = current_user.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:title, :provider, :html, :slide_url)
  end
end

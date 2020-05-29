class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:edit, :update, :destroy]
  #@todo mostrar total de msgs da sala no badge e qual foi o horário da ultima msg enviada

  def index
  end

  def rooms_user
    @chat_rooms = ChatRoom.where(user_id: current_user.id)
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Sala de chat adicionada!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def update
    if @chat_room.update(chat_room_params)
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_user_path
    else
      render :edit
    end
  end

  def edit
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def destroy
    @chat_room.destroy
    flash[:notice] = 'A sala foi excluída'
    redirect_to chat_rooms_user_path
  end


  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
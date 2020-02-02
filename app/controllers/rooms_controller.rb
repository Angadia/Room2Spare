class RoomsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_room, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]

    
    def new
        @room = Room.new
    end 

    def index
        @rooms= Room.order(created_at: :DESC)
    end

    def show
        @availability = Availability.new
    end

    def create
        @facility = Facility.find(params[:facility_id])
        @room = Room.new room_params
        @room.facility = @facility
        # @room.user_id = 1
        if @room.save
          redirect_to @facility
        else
          @rooms = @facility.rooms.order(created_at: :desc)
          render 'facilities/show'
        end
    end

    private

    def find_room
        @room = Room.find params[:id]
    end
    
    def room_params
        params.require(:room).permit(:capacity, :area, :whiteboard, :internet, :name)
    end

    def authorize!
        redirect_to room_path(@room), alert: "access denied" unless can? :crud, @room
    end

end

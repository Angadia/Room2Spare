class RoomsController < ApplicationController
    
    def new
        @room = Room.new
    end 

    def index
        @rooms= Room.order(created_at: :DESC)
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
        params.require(:room).permit(:capicity, :area, :whiteboard, :internet, :name)
    end
end

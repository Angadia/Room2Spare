class AvailabilitiesController < ApplicationController
    
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_room
    before_action :authorize!, only: [:create, :destroy]

    def create
        @availability = Availability.new availability_params
        @availability.room_id = params[:room_id]
        @availability.room = @room
        @availability.user = current_user
        if @availability.save # perform validation and if succesful it will save in db
            flash[:notice] = 'Availability Created Successfully'
            redirect_to room_path(@availability.room_id)
        else
            flash[:danger] = @availability.errors.full_messages.join(', ')
            @availabilities = @room.availabilities.order(created_at: :desc)
            render 'rooms/show'
        end
    end
    
    def destroy
        @availability = Availability.find params[:id]
        @availability.destroy
        flash[:notice] = 'Availability Deleted Successfully'
        redirect_to room_path(@availability.room_id)  
    end

    private

    def availability_params
        params.require(:availability).permit(:start_date, :end_date,:start_time, :end_time, :one_hour_rental_price)
    end

    def find_room
        @room = Room.find params[:room_id]
    end

    def authorize!
        redirect_to @room, alert: "access denied" unless can? :crud, @availability
    end

end

class FacilitiesController < ApplicationController

    before_action :find_facility, only: [:show, :edit, :update, :destroy]

    def new
        @facility = Facility.new
    end 

    def create 
        @facility = Facility.new facility_params
        @facility.user_id = current_user
        if @facility.save
            redirect_to @facility
        else
            render :new
        end
    end 


    def index 
        @facilities = Facility.order(created_at: :DESC)
    end 

    def show
        @rooms = Room.new
        @rooms = @facility.rooms.order(created_at: :desc)
    end

    def edit
    end

    def update
        if @facility.update facility_params
            redirect_to facility_path(@facility)
        else
            render :edit
        end
    end 

    def destroy
        @facility.destroy
        redirect_to facilities_path
    end 


    private 

    def facility_params
        params.require(:facility).permit(:name, :description, :address, :city, :postal_code, :contact_number, :parking)
      end

    def find_facility
        @facility = Facility.find params[:id]
    end

   

end

class FacilitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_facility, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, except: [:index, :create, :show, :new]

    def new
        @facility = Facility.new
    end

    def create 
        @facility = Facility.new facility_params
        @facility.user = current_user
        if @facility.save
            flash[:notice] = 'Facility Created Successfully'
            redirect_to @facility
        else
            render :new
        end
    end 


    def index 
        if current_user.is_manager?
            user = current_user
            @facilities = user.facilities
        elsif params[:search]
            @search_term = params[:search]
            @facilities = Facility.search_by(@search_term)
        else
            @facilities = Facility.order(created_at: :DESC)
        end
        
    end 

    def show
        if can? :crud, @facility
        @room = Room.new
        end
        # if params[:search]
        #     @search_term = params[:search]
        #     @rooms = Room.search_by(@search_term)
        # else
            @rooms = @facility.rooms.order(created_at: :desc)
        # end
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

    def authorize!
        redirect_to root_path, alert: "access denied" unless can? :crud, @facility
    end

end


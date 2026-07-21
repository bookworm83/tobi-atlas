class TripsController < ApplicationController
  before_action :require_login
  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      @trip.update(stock_photo_url: UnsplashClient.fetch_photo_url(@trip.name))
      redirect_to trips_path, notice: 'Trip created successfully!'
    else
      render :new
    end
  end
  def show
    @trip = current_user.trips.find(params[:id])
  end

  def edit
    @trip = current_user.trips.find(params[:id])
  end

  def update
    @trip = current_user.trips.find(params[:id])
    @trip.update(trip_params)
    redirect_to @trip
  end

  def destroy
    @trip = current_user.trips.find(params[:id])
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_path }
      format.json { head :no_content }
    end
  end
  def search
    @trips = current_user.trips
    @trips = @trips.search(params[:query]) if params[:query].present?
    @trips = @trips.by_date_range(params[:start_date], params[:end_date]) if params[:start_date].present?
    render json: @trips
  end

  private
  def require_login
    redirect_to login_path unless current_user
  end
  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :notes, :photo)
  end
end

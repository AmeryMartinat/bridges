class TripsController < ApplicationController
  # GET /trips
  def index
    @trips = Trip.all
  end

  # GET /trips/1
  def show
    @trip = Trip.find(params[:id])
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    @trip.travelers.build
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to(@trip, :notice => 'Trip was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /trips/1
  def update
  @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to(@trip, :notice => 'Project was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /trips/1
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to(trips_url)
  end

  private

  def trip_params
    params.require(:trip).permit(
      :name,
      travelers_attributes: [:id, :_destroy, :name, :speed],
      bridges_attributes: [:id, :_destroy, :name, :length, travelers_attributes: [:id, :_destroy, :name, :speed] ],
    )
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # If you want to authenticate the user first
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || events_path
  end

  private 

  def build_park_array
   @parks = Park.all
   @parksmap = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.name, x.streetNumber, x.streetName, ["Playgrounds"], x.id]}
   @parksmap2 = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.id]}
 end
end

	
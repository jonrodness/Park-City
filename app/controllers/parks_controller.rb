class ParksController < ApplicationController
	layout 'event_park_layout'
		before_action :build_park_array, only: [:index]
		before_action :authenticate_user!, only: [:show, :index]

	def index
		@type = "index"
		@park_list = Park.all.order(name: :asc)
		@parks = @park_list.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.name, x.streetNumber, x.streetName, ["Playgrounds"], x.id]}
		@title = "Parks"
	end

	def reparse_park_data
		@helper = Park.XMLparser
		redirect_to events_path
	end

	private 

	def build_park_array
			@parks = Park.all
			@parksmap = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.name, x.streetNumber, x.streetName, ["Playgrounds"], x.id]}
			@parksmap2 = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.id]}
	end

end

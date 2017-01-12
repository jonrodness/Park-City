class EventsController < ApplicationController
	layout 'event_park_layout'

	before_action :find_event, only: [:show, :edit, :update, :destroy, :join, :unjoin]
	before_action :build_park_array, only: [:index, :new, :show, :edit, :my_joined_events, :my_created_events, :this_park_events, :search]
	before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy, :my_joined_events, :my_created_events, :this_park_events, :search]
	skip_before_filter :verify_authenticity_token, :only => [:search]

	def index
		@events = Event.all.where("date >= curdate()").order(date: :asc)
		build_park_array
		@type = "index"
		@title = "All Events"
	end

	def reparse_park_data
		@helper = Park.XMLparser
		redirect_to events_path
	end

	def new
		@type = "new"
		@park_id = params[:park_param]
		@event = current_user.events.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			current_user.events << @event
			@event.update(:creator_id => current_user.id)
			redirect_to events_url, :flash => { :notice => "#{@event.title} has been successfully created" }
		else
			@parks = Park.all
			
			render :new
		end
	end

	def show
	end

	def edit
		@park_id = params[:park_param]
	end

	def update
		if @event.update(event_params)
			redirect_to @event
		else
			@parks = Park.all
			render "edit"
		end    
	end

  # DELETE /events/1
  def destroy
  	@event.destroy
  	redirect_to events_url
  end

  def join
  	if !@event.users.exists?(current_user.id)
  		current_user.events << @event
  		redirect_to @event, :flash => { :notice => "You have successfully joined #{@event.title}" }
  	else
  		redirect_to @event, :flash => { :alert => "You are already on the list for #{@event.title}" }
  	end
  end

  def unjoin
  	if  @event.users.exists?(current_user.id)
  		current_user.events.delete(@event)
  		redirect_to @event, :flash => { :notice => "You have successfully unjoined #{@event.title}" }
  	else
  		redirect_to @event, :flash => { :alert => "You had never joined #{@event.title}" }
  	end
  end

  def my_joined_events
  	@events = Event.all.where("creator_id = #{current_user.id}").where("date >= curdate()").order(date: :asc)
  	@title = "My Joined Events"
  	render "index"
  end

  def my_created_events
  	@events = current_user.events.where("date >= curdate()").order(date: :asc)
  	@title = "My Created Events"
  	render "index"
  end

  def this_park_events
  	this_park_id = params[:park_param]
  	@park = Park.find(this_park_id)
  	@events = Event.all.where("park_id = #{this_park_id}").where("date >= curdate()")
  	@title = "Events at #{@park.name}"
  	render "index"
  end

  def search
  	query = params[:query]
  	@events = Event.all.where("title LIKE '%#{query}%'")
  	render "index"
  end

  private
  
  def event_params
  	params.require(:event).permit(:title, :date, :spots, :description, :park_id, :time, :query)
  end

  def find_event
  	@event = Event.find(params[:id])
  end

  def build_park_array
  	@parks = Park.all
  	@parksmap = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.name, x.streetNumber, x.streetName, ["Playgrounds"], x.id]}
  	@parksmap2 = @parks.map{|x| [x.googleMapDest.split(',').first.to_f, x.googleMapDest.split(',').second.to_f, x.id]}
  end

end

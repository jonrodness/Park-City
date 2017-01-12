class Event < ActiveRecord::Base
	validates :title, :presence => true
	validates :date, :presence => true
	validates :time, :presence => true
	validates_date :date, :on_or_after => Date.today

	belongs_to :park
	has_and_belongs_to_many :users
end

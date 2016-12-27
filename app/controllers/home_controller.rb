class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @recent_events = Event.last(4)
    @todays_events = Event.last(4)
    @last_events = Event.last(4)
  end
end

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @recent_events = Event.where(start_date: (Time.zone.now - 6.hours)..Time.zone.now)
    @todays_events = Event.where('start_date >= ? AND end_date <= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
    @last_events = Event.order(created_at: :asc).last(4)
  end
end

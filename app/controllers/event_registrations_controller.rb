class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:update]
  def create
    @event_registration = EventRegistration.new(event_registration_params)

    respond_to do |format|
      if EventRegistration.where(user_id: event_registration_params[:user_id], event_id: event_registration_params[:event_id]).count.zero? && @event_registration.save
        format.js   { head :ok }
      else
        format.js   { head :bad_request }
      end
    end
  end

  def update
    respond_to do |format|
      if @event_registration.event.open_spot_left? && @event_registration.update(event_registration_params)
        format.js   { head :ok }
      else
        format.js   { head :bad_request }
      end
    end
  end

  private

  def set_event
    @event_registration = EventRegistration.find(params[:id])
  end

  def event_registration_params
    params.require(:event_registration).permit(:event_id, :user_id, :confirmed)
  end
end

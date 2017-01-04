class EventRegistrationsController < ApplicationController
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

  end

  private

  def event_registration_params
    params.require(:event_registration).permit(:event_id, :user_id)
  end
end

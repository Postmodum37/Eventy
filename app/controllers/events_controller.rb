class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to edit_event_path(@event), flash: { success: t('flash.event.created') }
    else
      redirect_to :back, flash: { warning: t('flash.event.creation_error') }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to :back, flash: { success: t('flash.success') }
    else
      redirect_to :back, flash: { warning: t('flash.unsuccessful') }
    end
  end

  def destroy
    @event.destroy
    redirect_to :back, flash: { success: t('flash.dsuccess') }
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit!
  end
end

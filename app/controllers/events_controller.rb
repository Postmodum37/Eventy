class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:destroy, :block_event_owner]
  before_action :authorize_creator, only: [:edit, :update]
  before_action :available_for_edit, only: [:edit]

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
      redirect_to :back, flash: { success: t('flash.event.updated') }
    else
      redirect_to :back, flash: { warning: t('flash.event.update_error') }
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, flash: { success: t('flash.event.deleted') }
  end

  def index
    @events = Event.search(params)
  end

  def block_event_owner
    @event = Event.find(params[:event_id])
    if blocking_params.eql?('true')
      @event.user.update_column(:blocked, true)
      redirect_back fallback_location: root_path, flash: { success: t('flash.event.owner_blocked') }
    elsif blocking_params.eql?('false')
      @event.user.update_column(:blocked, false)
      redirect_back fallback_location: root_path, flash: { success: t('flash.event.owner_unblocked') }
    end
  end

  private

  def available_for_edit
    redirect_back fallback_location: root_path, flash: { info: t('flash.event.cant_edit_event') } unless @event.available_for_edit?
  end

  def authorize_admin
    redirect_back fallback_location: root_path, flash: { danger: t('flash.authorize_admin_error') } unless current_user.admin?
  end

  def authorize_creator
    redirect_back fallback_location: root_path, flash: { danger: t('flash.authorize_creator_error') } unless @event.user.eql?(current_user) || current_user.admin?
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit!
  end

  def blocking_params
    params.require(:block)
  end
end

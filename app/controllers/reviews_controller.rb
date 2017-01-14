class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:destroy]

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event = Event.find(params[:event_id])
    if @review.save
      redirect_back fallback_location: root_path, flash: { success: t('flash.review.created') }
    else
      redirect_back fallback_location: root_path, flash: { warning: t('flash.review.creation_error') }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_back fallback_location: root_path, flash: { success: t('flash.review.deleted') }
  end

  private

  def authorize_admin
    redirect_back fallback_location: root_path, flash: { danger: t('flash.authorize_admin_error') } unless current_user.admin?
  end

  def review_params
    params.require(:review).permit(:body, :user_id, :rating, :event_id)
  end
end

class ReviewsController < ApplicationController
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

  private

  def review_params
    params.require(:review).permit(:body, :user_id, :rating, :event_id)
  end
end

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable
  before_action :authorize_admin, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: root_path, flash: { success: t('flash.comment.created') }
    else
      redirect_back fallback_location: root_path, flash: { warning: t('flash.comment.creation_error') }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path, flash: { success: t('flash.comment.deleted') }
  end

  private

  def authorize_admin
    redirect_back fallback_location: root_path, flash: { danger: t('flash.authorize_admin_error') } unless current_user.admin?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
    @commentable = Event.find_by(id: params[:event_id]) if params[:event_id]
  end
end

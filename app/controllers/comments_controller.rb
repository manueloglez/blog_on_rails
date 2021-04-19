class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = Post.find params[:post_id]
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      redirect_to post_path(@comment.post)
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post)
  end
end

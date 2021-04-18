class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = Post.find params[:post_id]
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

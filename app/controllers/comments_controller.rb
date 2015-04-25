class CommentsController < ApplicationController
  
  before_action :find_idea
  before_action :find_comment

  def index
    
  end

  def create
    @idea             = Idea.find params[:idea_id]
    @comment          = Comment.new(comment_params)
    @comment.user     = current_user
    @comment.idea = @idea
    
    if @comment.save
      redirect_to idea_path(@idea), 
                    notice: "comment created!"
    else
      render "ideas/show"
    end
  end

  def edit

  end

  def update
    if @comment.update comment_params
      redirect_to @idea, notice: "Comment successfully updated"
    else
      render :edit
    end
  end


  def destroy
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to idea_path(@idea), 
                  notice: "comment deleted"
  end

private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end

  def find_comment
    @comment = Comment.find params[:comment_id]
  end


  def comment_params
      params.require(:comment).permit(:body)
  end
end

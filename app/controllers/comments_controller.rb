class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!, only: %i[ create new edit update destroy ]


  # POST /comments or /comments.json
  def create
    comment = @post.comments.create! params.required(:comment).permit(:content)
    comment.created_by = current_user.id
    comment.created_by_name = current_user.name
    comment.save!
    # CommentsMailer.submitted(comment).deliver_later
    redirect_to @post
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

end

class CommentsController < ApplicationController
  before_action :set_post


  # POST /comments or /comments.json
  def create
    comment = @post.comments.create! params.required(:comment).permit(:content)
    # CommentsMailer.submitted(comment).deliver_later
    redirect_to @post
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

end

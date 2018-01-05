class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create_comment
		@comment = Comment.new(comment_params)
		@comment.save
		respond_to do |format|
			if params[:tags] == "SHOW"
				format.js {redirect_to tweet_path(@comment.tweet)}
			else
				format.js {redirect_to home_index_path}
			end
		end
	end

	private

	def comment_params
    params.require(:comment).permit(:message, :attachment, :tweet_id, :user_id)
  end

end

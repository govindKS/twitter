class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create_comment
		# @comment = Comment.new(comment_params)
		@comment = Comment.new(
						  commentable_id: params[:comment][:commentable_id],
						  commentable_type: params[:comment][:commentable_type],
						  message: params[:comment][:message],
						  user_id: params[:comment][:user_id],
						  attachment: params[:comment][:attachment]
						)
		@comment.save
		respond_to do |format|
			flash[:notice] = "Comment added successfully!"
			if params[:tags] == "SHOW" and @comment.commentable_type == "Comment"
				format.js {redirect_to tweet_path(id: params[:tweet_id])}
			elsif params[:tags] == "SHOW"
				format.js {redirect_to tweet_path(@comment.commentable)}
			else
				format.js {redirect_to home_index_path}
			end
		end
	end

	private

	# def comment_params
 #    params.require(:comment).permit(:message, :attachment, :tweet_id, :user_id)
 #  end

end

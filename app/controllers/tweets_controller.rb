class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = current_user.tweets
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @total_liked = @tweet.likes.where(:is_like => true)
    @total_comments = @tweet.comments
    # @retweets = Tweet.where(:current_tweet_id => @tweet.id, is_retweet: true)
    @retweets = Tweet.get_retweet(@tweet.id)
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Re-Tweet
  def retweet
    @retweet = Tweet.create(message: @tweet.message, attachment: @tweet.attachment, :user_id => current_user.id, is_retweet: true, current_tweet_id: @tweet.id)
    respond_to do |format|
      flash[:notice] = "Re-Tweet has been successfully"
      format.html {redirect_to home_index_path}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:message, :attachment, :user_id, :is_retweet, :current_tweet_id)
    end
end

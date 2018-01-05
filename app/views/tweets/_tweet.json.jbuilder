json.extract! tweet, :id, :message, :attachment, :user_id, :is_retweet, :current_tweet_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)

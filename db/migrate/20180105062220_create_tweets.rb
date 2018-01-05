class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :message
      t.string :attachment
      t.integer :user_id
      t.boolean :is_retweet, default: false
      t.string :current_tweet_id

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
    	t.text :message
    	t.string :attachment
    	# t.integer :tweet_id
    	t.integer :commentable_id
    	t.string	:commentable_type
    	t.integer :user_id
      t.timestamps
    end
  end
end

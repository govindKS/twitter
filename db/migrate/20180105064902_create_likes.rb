class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
    	t.integer :tweet_id
    	t.boolean :is_like, default: false
    	t.integer :user_id
      t.timestamps
    end
  end
end

class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
    	t.integer :following_user_id
    	t.integer :user_id
    	t.boolean :is_following, default: false
      t.timestamps
    end
    add_index :followings, :following_user_id
    add_index :followings, :user_id
  end
end

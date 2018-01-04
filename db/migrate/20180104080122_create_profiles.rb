class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :about_me
      t.date :date_of_birth
      t.string :profile_image
      t.integer :user_id

      t.timestamps
    end
  end
end

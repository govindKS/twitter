json.extract! profile, :id, :first_name, :last_name, :about_me, :date_of_birth, :profile_image, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)

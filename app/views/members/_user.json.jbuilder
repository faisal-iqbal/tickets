json.extract! user, :id, :role, :email
json.url member_url(id:user.id, format: :json)
json.extract! comment, :id, :body, :status, :user_id, :ticket_id, :created_at, :updated_at
if comment.user.present?
  json.user_email comment.user.email
end
json.url comment_url(comment, format: :json)
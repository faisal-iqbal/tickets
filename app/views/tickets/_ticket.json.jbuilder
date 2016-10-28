json.extract! ticket, :id, :title, :description, :status, :status_str, :user_id, :owner_id, :created_at, :updated_at
if ticket.user.present?
  json.user_email ticket.user.email
end
if ticket.owner.present?
  json.owner_email ticket.owner.email
end
json.url ticket_url(ticket, format: :json)
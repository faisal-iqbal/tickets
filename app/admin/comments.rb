ActiveAdmin.register Comment do
  #menu :parent => "Ticket Management"

  filter :body
  filter :ticket
  filter :user
  filter :created_at
  filter :status
end
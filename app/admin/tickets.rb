ActiveAdmin.register Ticket do
  #menu :parent => "Ticket Management"

  filter :title
  filter :user
  filter :created_at
  filter :status
end
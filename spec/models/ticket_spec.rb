require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context "status_str value should change according to status" do
    it "for status:0 status_str should be 'open'" do
      ticket = Ticket.new(status: 0)
      expect(ticket.status_str).to eq :open
    end
    it "for status:1 status_str should be 'reopened'" do
      ticket = Ticket.new(status: 1)
      expect(ticket.status_str).to eq :reopened
    end
    it "for status:3 status_str should be 'assigned'" do
      ticket = Ticket.new(status: 2)
      expect(ticket.status_str).to eq :assigned
    end
    it "for status:4 status_str should be 'closed'" do
      ticket = Ticket.new(status: 3)
      expect(ticket.status_str).to eq :closed
    end
  end
  
end

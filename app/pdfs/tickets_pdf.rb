class TicketsPdf < Prawn::Document
  def initialize(tickets, start_date)
    super(top_margin: 70)
    @tickets = tickets
    page_header(start_date)
    tickets_table
    page_footer_note(start_date)
  end

  def page_header(start_date)
    text "Tickets closed since #{start_date.strftime('%e %b, %Y')}", size: 30, style: :bold
  end

  def tickets_table
    move_down 20
    table ticket_rows do
      row(0).font_style = :bold
      columns(1..4).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def ticket_rows
    [["Title", "Created By", "Created At", "Closed By", "Closed At"]] +
    @tickets.map do |ticket|
      [ticket.title.to_s, (ticket.user.present? ? ticket.user.email.to_s : ''), ticket.created_at.strftime('%e %b, %Y'), ticket.owner_id.to_s, ticket.updated_at.strftime('%e %b, %Y')]
    end
  end

  def page_footer_note(start_date)
    move_down 15
    text "Total #{@tickets.count} tickets closed since #{start_date.strftime('%e %b, %Y')}", size: 16, style: :bold
  end

end
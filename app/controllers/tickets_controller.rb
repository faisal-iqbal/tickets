class TicketsController < ApplicationController
  before_action :authenticate!
  before_action :authenticate_admin!, only: [:destroy]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :mark_close, :reopen]

  # GET /tickets
  # GET /tickets.json
  def index
    if params[:closed_in_last_month].present?
      @start_date = 30.days.ago
      @tickets = Ticket.where(status: 0).where("updated_at > #{@start_date.to_date}")
    else  
      @tickets = Ticket.all
    end
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        pdf = TicketsPdf.new(@tickets, @start_date)
        send_data pdf.render, filename: "tickets.pdf", disposition: 'inline'
      end
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user if current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: {id: @ticket.id, status: :created}, status: :created }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render json: {status: :ok}, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /tickets/1/mark_close
  # PUT /tickets/1/mark_close.json
  def mark_close
    respond_to do |format|
      if @ticket.update({status: Ticket::STATUS[:closed]})
        format.html { redirect_to @ticket, notice: 'Ticket was successfully marked as close.' }
        format.json { render json: {status: :ok}, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1/reopen
  # PUT /tickets/1/reopen.json
  def reopen
    @ticket.status = Ticket::STATUS[:reopened]
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully reopened.' }
        format.json { render json: {status: :ok}, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :owner_id)
    end
end

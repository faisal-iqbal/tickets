class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: "User"

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {minimum: 1, maximum: 255}

  before_save :updates_for_owner

  attr_accessor :status_str

  STATUS = {
    open: 0,
    reopened: 1,
    assigned: 2,
    closed: 3
  }

  def status_str
    @status_str = Ticket::STATUS.keys[status.to_i]
  end

  private
    def updates_for_owner
      if self.owner_id.present?
        owner = User.find(self.owner_id)
        unless ['support_agent', 'admin'].include?(owner.role)
          self.owner_id = nil
        end
      end
    end

end

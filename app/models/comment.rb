class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :body, presence: true, length: {minimum: 1, maximum: 1000}
end

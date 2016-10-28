class User < ApplicationRecord
  include TokenAuthenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets, dependent: :destroy

  has_many :comments, dependent: :destroy
  
  ROLE = {support_agent: 'support_agent', admin: 'admin'}

  before_save :ensure_authentication_token
end

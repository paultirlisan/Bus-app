class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :company, dependent: :destroy
  has_many :journeys, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :company, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  #validates_associated :company

  def has_company?
  	!company.nil?
  end
end

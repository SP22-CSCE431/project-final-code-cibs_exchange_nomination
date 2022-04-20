# frozen_string_literal: true

class Representative < ApplicationRecord
  validates :first_name, :last_name, :title, :rep_email, presence: true
  validates :rep_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :students, dependent: :destroy
  belongs_to :university
end

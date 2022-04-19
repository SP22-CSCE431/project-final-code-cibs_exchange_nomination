# frozen_string_literal: true

class Student < ApplicationRecord
  validates :first_name, :last_name, :student_email, :exchange_term, :degree_level, :major,
            presence: true
  validates :student_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  belongs_to :university
  belongs_to :representative
  has_many :response, dependent: :destroy
end

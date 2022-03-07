class Student < ApplicationRecord
    validates :first_name, :last_name, :university_id, :nominator_id, :student_email, :exchange_term, :degree_level, :major, presence: true
    belongs_to :university
    belongs_to :nominator
    has_many :response , dependent: :destroy
end

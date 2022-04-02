class Hold < ApplicationRecord
    validates :user_id, :type, :max_limit, :student_num, presence: true
end

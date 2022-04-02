class CreateHolds < ActiveRecord::Migration[6.1]
  def change
    create_table :holds do |t|
      t.integer :user_id
      t.text :type
      t.integer :curr_students
      t.integer :student_num
      t.integer :max_limit

      # common
      t.string :first_name
      t.string :last_name
      t.integer :university_id

      # student
      t.string :student_email
      t.string :exchange_term
      t.string :degree_level
      t.string :major
      t.integer :representative_id

      # rep
      t.string :title
      t.string :rep_email

      # response
      t.string :reply
      t.integer :question_id
      t.references :student

      t.timestamps
    end
  end
end

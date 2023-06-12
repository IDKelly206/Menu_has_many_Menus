class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.references :meal, null: false, foreign_key: true
      t.string :course_type

      t.timestamps
    end
  end
end

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :status
      t.text :skills
      t.references :recruiter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

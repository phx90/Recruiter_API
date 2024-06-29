class AddIndexesToJobsAndSubmissions < ActiveRecord::Migration[6.0]
  def change
    unless index_exists?(:jobs, :recruiter_id)
      add_index :jobs, :recruiter_id
    end
    
    unless index_exists?(:submissions, :job_id)
      add_index :submissions, :job_id
    end

    unless index_exists?(:submissions, [:job_id, :email], unique: true)
      add_index :submissions, [:job_id, :email], unique: true
    end
  end
end

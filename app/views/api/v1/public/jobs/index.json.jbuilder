json.jobs @jobs do |job|
  json.id job.id
  json.title job.title
  json.description job.description
  json.start_date job.start_date
  json.end_date job.end_date
  json.status job.status
  json.skills job.skills
  json.created_at job.created_at
  json.updated_at job.updated_at
end

json.meta do
  json.current_page @meta[:current_page]
  json.total_pages @meta[:total_pages]
  json.total_count @meta[:total_count]
end

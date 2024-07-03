json.jobs @jobs, partial: 'job', as: :job
json.meta do
  json.current_page @jobs.current_page
  json.next_page @jobs.next_page
  json.prev_page @jobs.prev_page
  json.total_pages @jobs.total_pages
  json.total_count @jobs.total_count
end

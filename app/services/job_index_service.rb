class JobIndexService
  def initialize(recruiter, params)
    @recruiter = recruiter
    @params = params
  end

  def call
    jobs = apply_search_filters
    {
      jobs: jobs,
      meta: pagination_meta(jobs)
    }
  end

  private

  def apply_search_filters
    query = @params[:search]
    page = @params[:page]
    per_page = @params[:per_page] || 25

    search_jobs(query, page, per_page)
  end

  def search_jobs(query, page, per_page)
    search_query = query.present? ? query : '*'
    Job.search(search_query, where: { status: ['active', 'open'], recruiter_id: @recruiter.id }, page: page, per_page: per_page)
  end

  def pagination_meta(jobs)
    {
      current_page: jobs.current_page,
      total_pages: jobs.total_pages,
      total_count: jobs.total_count
    }
  end
end

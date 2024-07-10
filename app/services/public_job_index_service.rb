class PublicJobIndexService
  def initialize(params)
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
    jobs = Job.active_or_open.ransack(
      m: 'or',
      title_cont: query,
      description_cont: query,
      skills_cont: query
    ).result
  
    jobs = Job.active_or_open.ransack({}).result unless query.present?
  
    jobs.page(@params[:page]).per(@params[:per_page] || 25)
  end
  

  def pagination_meta(jobs)
    {
      current_page: jobs.current_page,
      total_pages: jobs.total_pages,
      total_count: jobs.total_count
    }
  end
end

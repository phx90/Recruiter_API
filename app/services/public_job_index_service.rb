class PublicJobIndexService
    def initialize(params)
      @params = params
    end
  
    def call
      jobs = Job.active_or_open
      jobs = apply_search_filters(jobs) if @params[:search].present?
      paginated_jobs = jobs.page(@params[:page]).per(@params[:per_page] || 25)
      {
        jobs: paginated_jobs,
        meta: {
          current_page: paginated_jobs.current_page,
          total_pages: paginated_jobs.total_pages,
          total_count: paginated_jobs.total_count
        }
      }
    end
  
    private
  
    def apply_search_filters(jobs)
      jobs.search(@params[:search])
    end
  end
  
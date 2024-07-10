class RecruiterIndexService
  def initialize(params)
    @params = params
  end

  def call
    recruiters = apply_search_filters
    {
      recruiters: recruiters,
      meta: pagination_meta(recruiters)
    }
  end

  private

  def apply_search_filters
    query = @params[:search]
    recruiters = Recruiter.ransack(
      m: 'or',
      name_cont: query,
      email_cont: query
    ).result
    recruiters = Recruiter.ransack({}).result unless query.present?
  
    recruiters.page(@params[:page]).per(@params[:per_page] || 25)
  end
  

  def pagination_meta(recruiters)
    {
      current_page: recruiters.current_page,
      total_pages: recruiters.total_pages,
      total_count: recruiters.total_count
    }
  end
end

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
    page = @params[:page]
    per_page = @params[:per_page] || 25

    search_recruiters(query, page, per_page)
  end

  def search_recruiters(query, page, per_page)
    search_query = query.present? ? query : '*'
    Recruiter.search(search_query, where: {}, page: page, per_page: per_page)
  end

  def pagination_meta(recruiters)
    {
      current_page: recruiters.current_page,
      total_pages: recruiters.total_pages,
      total_count: recruiters.total_count
    }
  end
end

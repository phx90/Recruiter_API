class SubmissionsIndexService
  def initialize(job, params)
    @job = job
    @params = params
  end

  def call
    submissions = apply_search_filters
    {
      submissions: submissions,
      meta: pagination_meta(submissions)
    }
  end

  private

  def apply_search_filters
    query = @params[:search]
    page = @params[:page]
    per_page = @params[:per_page] || 25

    search_submissions(query, page, per_page)
  end

  def search_submissions(query, page, per_page)
    search_query = query.present? ? query : '*'
    @job.submissions.search(search_query, where: {}, page: page, per_page: per_page)
  end

  def pagination_meta(submissions)
    {
      current_page: submissions.current_page,
      total_pages: submissions.total_pages,
      total_count: submissions.total_count
    }
  end
end

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
      submissions = @job.submissions
  
      if @params[:search].present?
        query = @params[:search]
        submissions = submissions.ransack(
          m: 'or',
          name_cont: query,
          email_cont: query,
          mobile_phone_cont: query
        ).result
      end
  
      submissions.page(@params[:page]).per(@params[:per_page] || 25)
    end
  
    def pagination_meta(submissions)
      {
        current_page: submissions.current_page,
        total_pages: submissions.total_pages,
        total_count: submissions.total_count
      }
    end
  end
  
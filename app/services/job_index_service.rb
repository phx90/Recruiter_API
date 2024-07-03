class JobIndexService
    def initialize(recruiter, params)
      @recruiter = recruiter
      @params = params
    end
  
    def call
      @recruiter.jobs.page(@params[:page]).per(@params[:per_page] || 25)
    end
  end
  
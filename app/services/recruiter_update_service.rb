class RecruiterUpdateService
    def initialize(recruiter, params)
      @recruiter = recruiter
      @params = params
    end
  
    def call
      raise InvalidRecruiterError.new(@recruiter.errors) unless @recruiter.update(@params)
  
      @recruiter
    end
  end
  
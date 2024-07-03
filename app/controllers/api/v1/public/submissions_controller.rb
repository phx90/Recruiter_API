module Api
  module V1
    module Public
      class SubmissionsController < ApplicationController
        def create
          @job = Job.find(params[:job_id])
          result = SubmissionCreationService.new(@job, submission_params).call
          render_response(result)
        end

        private

        def submission_params
          params.require(:submission).permit(:name, :email, :mobile_phone, :resume)
        end

        def render_response(result)
          render json: result[:errors] || result[:submission], status: result[:status]
        end
      end
    end
  end
end

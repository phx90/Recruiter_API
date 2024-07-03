module Api
  module V1
    module Recruiter
      class JobsController < ApplicationController
        before_action :authorize_request
        before_action :set_job, only: %i[show update destroy]

        def index
          result = JobIndexService.new(@current_recruiter, params).call
          render json: result, status: :ok
        end

        def show
          result = JobShowService.new(@current_recruiter, params[:id]).call
          render json: result, status: :ok
        end

        def create
          result = JobCreationService.new(@current_recruiter, job_params).call
          render_response(result)
        end

        def update
          result = JobUpdateService.new(@job, job_params).call
          render_response(result)
        end

        def destroy
          JobDestroyService.new(@job).call
          head :no_content
        end

        private

        def set_job
          @job = JobShowService.new(@current_recruiter, params[:id]).call
        end

        def job_params
          params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills)
        end

        def render_response(result)
          if result[:errors]
            render json: result[:errors], status: result[:status]
          else
            render json: result[:job], status: result[:status]
          end
        end
      end
    end
  end
end

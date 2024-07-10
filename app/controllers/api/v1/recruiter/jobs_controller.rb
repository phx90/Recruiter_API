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
          job = @current_recruiter.jobs.build(job_params)
          return render json: job.errors, status: :unprocessable_entity unless job.save

          render json: job, status: :created
        end

        def update
          @job.assign_attributes(job_params)
          return render json: @job.errors, status: :unprocessable_entity unless @job.save

          render json: @job, status: :ok
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
          return render json: result[:errors], status: result[:status] if result[:errors]

          render json: result[:job], status: result[:status]
        end
      end
    end
  end
end

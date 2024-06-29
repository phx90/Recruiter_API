module Api
  module V1
    module Recruiter
      class JobsController < ApplicationController
        before_action :authorize_request
        before_action :set_job, only: %i[show update destroy]

        def index
          jobs = Rails.cache.fetch(cache_key_for_jobs, expires_in: 12.hours) do
            @current_recruiter.jobs.to_a
          end
          render json: jobs
        end

        def show
          render json: @job
        end

        def create
          @job = @current_recruiter.jobs.build(job_params)
          save_and_render_job(@job, :created)
        end

        def update
          @job.assign_attributes(job_params)
          save_and_render_job(@job)
        end

        def destroy
          @job.destroy
          expire_jobs_cache
          head :no_content
        end

        private

        def set_job
          @job = @current_recruiter.jobs.find(params[:id])
        end

        def job_params
          params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills)
        end

        def cache_key_for_jobs
          "recruiter_#{@current_recruiter.id}_jobs"
        end

        def expire_jobs_cache
          Rails.cache.delete(cache_key_for_jobs)
        end

        def save_and_render_job(job, status = :ok)
          if job.save
            expire_jobs_cache
            render json: job, status: status
          else
            render json: job.errors, status: :unprocessable_entity
          end
        end
      end
    end
  end
end

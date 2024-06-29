module Api
  module V1
    module Recruiter
      class JobsController < ApplicationController
        before_action :authorize_request
        before_action :set_job, only: %i[show update destroy]

        def index
          job_ids = Rails.cache.fetch(cache_key_for_jobs, expires_in: 12.hours) do
            @current_recruiter.jobs.page(params[:page]).per(params[:per_page] || 25).pluck(:id)
          end

          jobs = Job.where(id: job_ids).page(params[:page]).per(params[:per_page] || 25)

          render json: {
            jobs: jobs.as_json(only: %i[id title description start_date end_date status skills]),
            meta: pagination_meta(jobs)
          }
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
          "recruiter_#{@current_recruiter.id}_jobs_page_#{params[:page] || 1}_per_#{params[:per_page] || 25}"
        end

        def expire_jobs_cache
          Rails.cache.delete_matched("recruiter_#{@current_recruiter.id}_jobs_*")
        end

        def save_and_render_job(job, status = :ok)
          if job.save
            expire_jobs_cache
            render json: job, status: status
          else
            render json: job.errors, status: :unprocessable_entity
          end
        end

        def pagination_meta(jobs)
          {
            current_page: jobs.current_page,
            next_page: jobs.next_page,
            prev_page: jobs.prev_page,
            total_pages: jobs.total_pages,
            total_count: jobs.total_count
          }
        end
      end
    end
  end
end

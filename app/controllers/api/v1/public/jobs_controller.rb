module Api
  module V1
    module Public
      class JobsController < ApplicationController

        def index
          jobs = Rails.cache.fetch(cache_key_for_jobs, expires_in: 12.hours) do
            jobs = Job.where(status: 'active')
            jobs = apply_search_filters(jobs) if params[:search].present?
            jobs = jobs.page(params[:page]).per(params[:per_page])
            jobs.as_json(include: :submissions)
          end
          render json: {
            jobs: jobs,
            meta: pagination_meta(Job.where(status: 'active').page(params[:page]).per(params[:per_page]))
          }
        end

        def show
          job = Rails.cache.fetch(cache_key_for_job(params[:id]), expires_in: 12.hours) do
            Job.find(params[:id]).as_json(include: :submissions)
          end
          render json: job
        end

        private

        def apply_search_filters(jobs)
          search_query = sanitize_sql_like(params[:search])
          jobs.where('title ILIKE :query OR description ILIKE :query OR skills ILIKE :query', query: "%#{search_query}%")
        end

        # Sanitiza a entrada para evitar SQL Injection
        def sanitize_sql_like(query)
          query.gsub(/[%_]/, '\\\\\0')
        end

        def cache_key_for_jobs
          search = params[:search] || 'all'
          page = params[:page] || 1
          per_page = params[:per_page] || 25
          "public_jobs_#{search}_page_#{page}_per_#{per_page}"
        end

        def cache_key_for_job(id)
          "public_job_#{id}"
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

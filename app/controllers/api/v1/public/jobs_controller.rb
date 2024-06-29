module Api
  module V1
    module Public
      class JobsController < ApplicationController

        def index
          @jobs = Job.where(status: 'active')
          apply_search_filters if params[:search].present?
          render json: @jobs
        end


        def show
          @job = Job.find(params[:id])
          render json: @job
        end

        private


        def apply_search_filters
          search_query = sanitize_sql_like(params[:search])
          @jobs = @jobs.where('title ILIKE :query OR description ILIKE :query OR skills ILIKE :query', query: "%#{search_query}%")
        end

        # Sanitiza a entrada para evitar SQL Injection
        def sanitize_sql_like(query)
          query.gsub(/[%_]/, '\\\\\0')
        end
      end
    end
  end
end

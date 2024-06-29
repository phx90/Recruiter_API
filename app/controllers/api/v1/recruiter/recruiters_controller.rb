module Api
  module V1
    module Recruiter
      class RecruitersController < ApplicationController
        before_action :authorize_request, except: :create
        before_action :set_recruiter, only: %i[show update destroy]

        def index
          @recruiters = ::Recruiter.all
          render json: @recruiters
        end

        def show
          render json: @recruiter
        end

        def create
          @recruiter = ::Recruiter.new(recruiter_params)
          handle_save_or_update(@recruiter, :created)
        end

        def update
          handle_save_or_update(@recruiter)
        end

        def destroy
          @recruiter.destroy
        end

        private

        def set_recruiter
          @recruiter = ::Recruiter.find(params[:id])
        end

        def recruiter_params
          params.require(:recruiter).permit(:name, :email, :password)
        end

        def handle_save_or_update(resource, status = :ok)
          if resource.update(recruiter_params)
            render json: resource, status: status
          else
            render json: resource.errors, status: :unprocessable_entity
          end
        end
      end
    end
  end
end

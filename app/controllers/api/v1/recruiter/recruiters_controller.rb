module Api
  module V1
    module Recruiter
      class RecruitersController < ApplicationController
        before_action :authorize_request, except: [:create]
        before_action :set_recruiter, only: %i[show update destroy]

        rescue_from RecruiterNotFoundError, with: :render_not_found
        rescue_from InvalidRecruiterError, with: :render_invalid_recruiter

        def index
          result = RecruiterIndexService.new(params).call
          render json: result, status: :ok
        end

        def show
          render :show, status: :ok
        end

        def create
          @recruiter = RecruiterCreateService.new(recruiter_params).call
          render :create, status: :created
        end

        def update
          @recruiter = RecruiterUpdateService.new(@recruiter, recruiter_params).call
          render :update, status: :ok
        end

        def destroy
          RecruiterDestroyService.new(@recruiter).call
          render :destroy, status: :no_content
        end

        private

        def set_recruiter
          @recruiter = Recruiter.find_by(id: params[:id])
          raise RecruiterNotFoundError, "Recruiter with ID #{params[:id]} not found" unless @recruiter
        end

        def recruiter_params
          params.require(:recruiter).permit(:name, :email, :password)
        end

        def render_not_found(exception)
          render json: { error: exception.message }, status: :not_found
        end

        def render_invalid_recruiter(exception)
          render json: { errors: exception.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end

module Api
  module V1
    module Recruiter
      class RecruitersController < ApplicationController
        before_action :authorize_request, except: [:login, :create]
        before_action :set_recruiter, only: %i[show update destroy]

        rescue_from RecruiterNotFoundError, with: :render_not_found
        rescue_from InvalidRecruiterError, with: :render_invalid_recruiter

        def login
          @recruiter = ::Recruiter.find_by_email(login_params[:email])
          if @recruiter&.authenticate(login_params[:password])
            @token = jwt_encode(recruiter_id: @recruiter.id)
            render :login, status: :ok
          else
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end

        def index
          @recruiters = RecruiterIndexService.new.call
          render :index, status: :ok
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
          @recruiter = RecruiterShowService.new(params[:id]).call
        end

        def login_params
          params.permit(:email, :password)
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

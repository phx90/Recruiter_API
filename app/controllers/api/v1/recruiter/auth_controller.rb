module Api
  module V1
    module Recruiter
      class AuthController < ApplicationController
        before_action :authorize_request, except: :login

        def login
          @recruiter = ::Recruiter.find_by_email(login_params[:email])
          if @recruiter&.authenticate(login_params[:password])
            render json: { token: jwt_encode(recruiter_id: @recruiter.id) }, status: :ok
          else
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end

        private

        def login_params
          params.permit(:email, :password)
        end
      end
    end
  end
end

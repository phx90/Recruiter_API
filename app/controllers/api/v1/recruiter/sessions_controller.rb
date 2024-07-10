module Api
  module V1
    module Recruiter
      class SessionsController < ApplicationController
        def login
          @recruiter = ::Recruiter.find_by_email(login_params[:email])
          return render json: { error: 'Unauthorized' }, status: :unauthorized unless @recruiter&.authenticate(login_params[:password])

          @token = jwt_encode(recruiter_id: @recruiter.id)
          render :login, status: :ok
        end

        private

        def login_params
          params.permit(:email, :password)
        end
      end
    end
  end
end

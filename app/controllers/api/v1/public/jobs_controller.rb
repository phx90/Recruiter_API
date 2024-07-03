module Api
  module V1
    module Public
      class JobsController < ApplicationController

        def index
          result = PublicJobIndexService.new(params).call
          render json: result, status: :ok
        end

        def show
          result = PublicJobShowService.new(params[:id]).call
          if result[:error]
            render json: { error: result[:error] }, status: :not_found
          else
            render json: result, status: :ok
          end
        end
      end
    end
  end
end

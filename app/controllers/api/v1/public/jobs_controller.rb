module Api
  module V1
    module Public
      class JobsController < ApplicationController
        def index
          result = PublicJobIndexService.new(params).call
          @jobs = result[:jobs]
          @meta = result[:meta]
          render :index
        end

        def show
          result = PublicJobShowService.new(params[:id]).call

          return render json: { error: result[:error] }, status: :not_found if result.is_a?(Hash) && result[:error]

          @job = result
          render :show
        end
      end
    end
  end
end

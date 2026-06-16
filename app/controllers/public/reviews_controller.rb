module Public
  class ReviewsController < ApplicationController
    skip_before_action :authorize_request

    def show
      review_session = ReviewSession.find_by!(slug: params[:slug])
      render json: review_session
    end
  end
end

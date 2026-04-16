module Api
  class ReviewSessionsController < ApplicationController

    def create
      project = current_user.projects.find(params[:project_id])

      review_session = project.review_sessions.build(review_session_params)

      if review_session.save
        render json: review_session, status: :created
      else
        render json: { errors: review_session.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      review_session = ReviewSession.find(params[:id])
      render json: review_session
    end

    private

    def review_session_params
      params.permit(:name, :base_url)
    end
  end
end

module Api
  class ReviewSessionsController < ApplicationController
    def index
      review_sessions = current_user.projects.includes(review_sessions: :comments).flat_map(&:review_sessions)

      render json: review_sessions.map { |review_session|
        review_session.as_json.merge(
          unresolved_comments_count: review_session.comments.where(resolved: false).count
        )
      }
    end

    def create
      project = current_user.projects.find(params[:project_id])

      review_session = project.review_sessions.build(review_session_params)

    if review_session.save
      render json: review_session.as_json.merge(
        unresolved_comments_count: 0
      ), status: :created
    else
      render json: { errors: review_session.errors.full_messages }, status: :unprocessable_entity
    end
    end

    def show
      review_session = current_user.projects
                                  .joins(:review_sessions)
                                  .find_by(review_sessions: { id: params[:id] })
                                  &.review_sessions
                                  &.find(params[:id])

      if review_session
        render json: review_session
      else
        render json: { error: "Review session not found" }, status: :not_found
      end
    end

    def update
      review_session = find_user_review_session

      unless review_session
        return render json: { error: "Review session not found" }, status: :not_found
      end

      if review_session.update(review_session_params)
        render json: review_session.as_json.merge(
          unresolved_comments_count: review_session.comments.where(resolved: false).count
        ), status: :ok
      else
        render json: { errors: review_session.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      review_session = current_user.projects
                                  .includes(:review_sessions)
                                  .flat_map(&:review_sessions)
                                  .find { |session| session.id == params[:id].to_i }

      if review_session
        review_session.destroy
        head :no_content
      else
        render json: { error: "Review session not found" }, status: :not_found
      end
    end


    private
    def find_user_review_session
      ReviewSession.joins(:project)
                  .where(projects: { user_id: current_user.id })
                  .find_by(id: params[:id])
    end
    
    def review_session_params
      params.permit(:name, :base_url)
    end
  end
end
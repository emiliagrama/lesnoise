module Api
  class CommentsController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :create]

    def index
      review_session = ReviewSession.find(params[:review_session_id])
      comments = review_session.comments.order(created_at: :asc)
      render json: comments
    end

    def create
      review_session = ReviewSession.find(params[:review_session_id])
      comment = review_session.comments.build(comment_params)

      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(
        :body,
        :author_name,
        :page_url,
        :page_path,
        :x_percent,
        :y_document,
        :viewport_width,
        :viewport_height
      )   
     end
  end
end

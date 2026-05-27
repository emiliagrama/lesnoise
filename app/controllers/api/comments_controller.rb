module Api
  class CommentsController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :create, :update, :destroy]

    def index
      review_session = ReviewSession.find(params[:review_session_id])
      comments = review_session.comments.order(created_at: :asc)
      render json: comments
    end

    def create
      review_session = ReviewSession.find(params[:review_session_id])
      comment = review_session.comments.build(comment_params)

      if comment.save
        ActionCable.server.broadcast(
          "review_session_#{review_session.id}",
          {
            action: "created",
            comment: comment,
            unresolved_comments_count: review_session.comments.where(resolved: false).count
          }
        )

        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      review_session = ReviewSession.find(params[:review_session_id])
      comment = review_session.comments.find(params[:id])

      if comment.update(comment_params)
        ActionCable.server.broadcast(
          "review_session_#{review_session.id}",
          {
            action: "updated",
            comment: comment,
            unresolved_comments_count: review_session.comments.where(resolved: false).count
          }
        )

        render json: comment
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      review_session = ReviewSession.find(params[:review_session_id])
      comment = review_session.comments.find(params[:id])

      comment.destroy

      ActionCable.server.broadcast(
        "review_session_#{review_session.id}",
        {
          action: "deleted",
          comment_id: comment.id,
          unresolved_comments_count: review_session.comments.where(resolved: false).count
        }
      )

      head :no_content
    end

    private

    def comment_params
      params.require(:comment).permit(
        :body,
        :author_name,
        :page_url,
        :page_path,
        :x_percent,
        :y_percent,
        :x_document,
        :y_document,
        :element_selector,
        :x_element,
        :y_element,
        :viewport_width,
        :viewport_height,
        :resolved,
        :author_type,
      )
    end
  end
end
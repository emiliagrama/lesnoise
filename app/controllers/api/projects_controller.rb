module Api
  class ProjectsController < ApplicationController

    def index
      projects = current_user.projects
      render json: projects
    end

    def create
      project = current_user.projects.build(project_params)

      if project.save
        render json: project, status: :created
      else
        render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      project = current_user.projects.find(params[:id])
      render json: project
    end

    private

    def project_params
      params.permit(:name)
    end
  end
end
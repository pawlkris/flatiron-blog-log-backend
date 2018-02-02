class Api::CohortsController < ApplicationController
  def index
    @cohorts = Cohort.all
    render json: @cohorts
  end

  def show
    @cohort = Cohort.find(params[:id])
    render json: @cohort
  end

  def update
    @cohort = Cohort.find(params[:id])

    @cohort.update(cohort_params)
    if @cohort.save
      render json: @cohort
    else
      render json: {errors: @cohort.errors.full_messages}, status: 422
    end
  end

  private
  def cohort_params
    params.permit(:title, :content)
  end

end

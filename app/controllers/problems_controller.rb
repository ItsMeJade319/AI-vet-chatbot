class ProblemsController < ApplicationController
  def new
    @problem = Problem.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @problem = Problem.new(problem_params)
    @pet = Pet.find(params[:pet_id])
    @problem.pet = @pet
    if @problem.save
      redirect_to problem_path(@problem)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @problem = Problem.find(params[:id])
    @message = Message.new
  end

  private

  def problem_params
    params.require(:problem).permit(:description)
  end
end

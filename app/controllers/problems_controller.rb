class ProblemsController < ApplicationController
  def new
    @problem = Problem.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @problem = Problem.new(problem_params)
    @pet = Pet.find(params[:pet_id])
    @problem.pet = @pet
    @problem.title = 'untitled'
    gen_title
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

  def gen_title
    return if @problem.title != 'untitled'

    new_title = RubyLLM.chat.with_instructions("make short title according to the description").ask(@problem.description).content
    @problem.title = new_title
  end

  def problem_params
    params.require(:problem).permit(:description)
  end
end

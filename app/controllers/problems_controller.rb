class ProblemsController < ApplicationController
  def new
    @problem = Problem.new
    @pet = Pet.find(params[:pet_id])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("main_panel", partial: "problems/form",
                                                               locals: { pet: @pet, problem: @problem })
      end
      format.html
    end
  end

  def create
    @problem = Problem.new(problem_params)
    @pet = Pet.find(params[:pet_id])
    @problem.pet = @pet
    @problem.title = 'untitled'

    gen_title

    if @problem.save
      @problems = @pet.problems.order(created_at: :desc)
      @message = Message.new

      respond_to do |f|
        f.turbo_stream do
          render turbo_stream: [turbo_stream.update("chats_container", partial: "pets/chats_container",
                                                                       locals: { problems: @problems }),

                                turbo_stream.update("main_panel", partial: "problems/chat",
                                                                  locals: { pet: @pet, problem: @problem, message: @message })]
        end
        f.html
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @problem = Problem.find(params[:id])
    @message = Message.new

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("main_panel", template: "problems/show",
                                                               locals: { problem: @problem, message: @message })
      end
      format.html
    end
  end

  private

  def gen_title
    return if @problem.title != 'untitled'

    begin
      new_title = RubyLLM.chat.with_instructions(instructions).ask(@problem.description).content
      @problem.title = new_title
    rescue RubyLLM::BadRequestError => e
      # Logs the exact Azure policy error to your production logs
      Rails.logger.warn "RubyLLM filtered content for problem description: #{e.message}"

      # Fallback title so the record can still save and the user isn't blocked
      @problem.title = "Untitled (Content Flagged)"
    end
  end

  def instructions
    "make short title according to the description and the description of the pet #{pet_context}
    if any value is undesirable, replace that word with a funny one if possible, if not return 'undesire word"
  end

  def pet_context
    "Here is the description and details of my pet years: #{@pet.age_years}, months: #{@pet.age_months} name: #{@pet.name}, species #{@pet.species}
    breed: #{@pet.breed}, weight: #{@pet.weight}kg"
  end

  def problem_params
    params.require(:problem).permit(:description)
  end
end

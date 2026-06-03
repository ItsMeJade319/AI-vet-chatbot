class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a Vet.\n\nI am a pet owner that has issues with their pet.\n\nHelp me me to identify these
  issues with the symptoms and descriptions that i give you about my pet.\n\nAnswer concisely in Markdown."

  def create
    @problem = Problem.find(params[:problem_id])
    @pet = @problem.pet
    @message = Message.new(message_params)
    @message.problem = @problem
    @message.role = "user"
    if @message.save
      @llm = RubyLLM.chat
      build_conversation_history
      response = @llm.with_instructions(instructions).ask(@message.content)
      @assistant_message = @problem.messages.create(role: "assistant", content: response.content)
      redirect_to problem_path(@problem)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def pet_context
    "Here is the description and details of my pet age: #{@pet.age}, name: #{@pet.name}, species #{@pet.species}
    breed: #{@pet.breed}, weight: #{@pet.weight}"
  end

  def build_conversation_history
    @problem.messages.each do |message|
      @llm.add_message(message)
    end
  end

  def instructions
    [SYSTEM_PROMPT, pet_context, @problem.description].compact.join("\n\n")
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

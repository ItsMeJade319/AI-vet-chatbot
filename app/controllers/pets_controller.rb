class PetsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)

    if @pet.save
      redirect_to pets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :weight, :breed)
  end
end

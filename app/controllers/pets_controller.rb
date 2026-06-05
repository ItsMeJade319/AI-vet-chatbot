class PetsController < ApplicationController
  def index
    @pets = current_user.pets
  end

  def show
    @pet = Pet.find(params[:id])
    @problems = @pet.problems.order(created_at: :desc)
    @vaccinations = @pet.vaccinations
    @problem = Problem.new
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user

    if @pet.save
      redirect_to pets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])

    if @pet.update(pet_params)
      redirect_to pet_path(@pet)
    else
      puts @pet.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :weight, :species, :breed, :age_years, :age_months)
  end
end

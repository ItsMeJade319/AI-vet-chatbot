class VaccinationsController < ApplicationController
  def new
    @pet = Pet.find(params[:pet_id])
    @vaccination = Vaccination.new
  end

  def create
    @pet = Pet.find(params[:pet_id])
    @vaccination = @pet.vaccinations.build(vaccination_params)

    if @vaccination.save
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find(params[:pet_id])
    @vaccination = @pet.vaccinations.find(params[:id])
  end

  def update
    @vaccination = Vaccination.find(params[:id])

    if @vaccination.update(vaccination_params)
      redirect_to pet_path(@vaccination.pet), notice: "Vaccination updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def vaccination_params
    params.require(:vaccination).permit(
      :brand,
      :description,
      :diseases,
      :target_species
    )
  end
end

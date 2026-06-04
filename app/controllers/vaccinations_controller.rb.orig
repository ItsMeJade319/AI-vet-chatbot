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

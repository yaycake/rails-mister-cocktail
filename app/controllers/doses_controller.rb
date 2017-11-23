class DosesController < ApplicationController
  before_action :find_cocktail, only: [:new, :create]
  before_action :set_dose, only: [:destroy, :show]

  def index
    @doses = Dose.all
  end

  def new
    @dose = Dose.new
  end

  def show
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @dose.ingredient = Ingredient.find_by_id(params["dose"]["ingredient_id"])
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose.destroy
    redirect_to cocktails_path
  end

  private

  def set_dose
    @dose = Dose.find(params[:id])
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end


  def dose_params
    params.require(:dose).permit(:ingredient, :description, :cocktail)
  end

end

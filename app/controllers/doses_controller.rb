class DosesController < ApplicationController
  before_action :find_cocktail, only: [:new, :create, :destroy]
  before_action :set_dose, only: [:destroy, :show]
  # before_action :find_ingredient, only: [:create]

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
    @dose.ingredient = @ingredient
    if @dose.save
      redirect_to cocktail_dose_path
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

  # def find_ingredient
  #   @ingredient = Ingredient.find(params[:ingredient_id])
  # end

  def dose_params
    params.require(:dose).permit(:ingredient, :description)
  end

end

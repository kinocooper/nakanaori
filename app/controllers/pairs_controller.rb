class PairsController < ApplicationController

  def new
    @pair = Pair.new
  end

  def create
    pair = params(pair_params)
    pair.save
    redirect_to about_path
  end

  def edit
  end

  def invite
  end

  def complete
  end

  def confirm
  end


  private

  def pair_params
    params.require(:pairs).permit(:name,:motto,:pair_type,:rank)
  end

end

class AddressesController < ApplicationController
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "The address was updated successfully"
    else
      flash[:error] = "There was a problem updating your address"
    end
    redirect_to edit_organization_path(@address.organization)
  end

  def create
    @address = Address.new(address_params)
    if @address.save!
      flash[:success] = "The address was added successfully"
    else
      flash[:error] = "There was a problem adding your address"
    end
    redirect_to edit_organization_path(@address.organization)
  end

  private

  def address_params
    params.require(:address).permit(:address1, :address2, :zip, :state, :country, :organization_id)
  end
end

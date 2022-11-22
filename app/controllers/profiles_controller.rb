class ProfilesController < ApplicationController
	before_action :authenticate_user!
	def show 
		@profile = Profile.find(params[:id])
	end
    def edit
		@profile = Profile.find(params[:id])
	end
	def update
		@profile = Profile.find(params[:id])
		if @profile.update(profiles_params)
      		redirect_to @profile
    	else
      		render :edit
    	end
	end


	private
	def profiles_params
		params.require(:profile).permit(:first_name, :last_name, :gender, :age, :house_no, :street, :city, :state, :country, :pincode)
	end

 end


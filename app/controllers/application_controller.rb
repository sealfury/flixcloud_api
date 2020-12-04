class ApplicationController < ActionController::API
	include DeviseTokenAuth::Concerns::SetUserByToken
	before_action :modify_permitted_params, if: :devise_controller?

	protected

	def modify_permitted_params
		added_attributes = [:name]
		devise_parameter_sanitizer.permit(:sign_up, keys: added_attributes)
	end
end

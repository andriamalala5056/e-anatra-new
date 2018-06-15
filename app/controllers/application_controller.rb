class ApplicationController < ActionController::Base
	before_action :configure_params_permit, if: :devise_controller?
	protected
	def configure_params_permit
		devise_parameter_sanitizer.permit(:sign_up, keys: [:nom, :prenom, :sexe, :date_de_naissance, :adresse, :telephone, :image])
		devise_parameter_sanitizer.permit(:account_update, keys: [:nom, :prenom, :sexe, :date_de_naissance, :adresse, :telephone, :image])
	end
end

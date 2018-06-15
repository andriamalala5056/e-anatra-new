class HomeController < ApplicationController
	def index
		@etablissements=Etablissement.page(1).per(6)
		UserMailer.welcome_email(nil).deliver_now
		if user_signed_in?
			if current_user.role=="responsable"
				session[:responsable] = 1
				@a = AssociateUserEtab.all
				#test = false
				@a.each do |assoc|
					if assoc.user == current_user
						# la personne a déjà un étab /  rédiriger vers son établissement
						#id de son etablissement
						#test = true
						#@id_etab = assoc.etablissement.i
						#test=true
						session[:etab_id] = assoc.etablissement.id
						#session[:etab_id] =  Etablissement.find_by(responsable_id: current_user.id).id
					end
				end
				
			end
		end
	end
end

class HomeController < ApplicationController
	def index
		@q = Etablissement.ransack(params[:q])
		@et = @q.result(distinct: true)
		#UserMailer.welcome_email(nil).deliver_now
	end
end

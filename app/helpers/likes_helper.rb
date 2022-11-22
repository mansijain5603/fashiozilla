module LikesHelper
	def already_like(like)
  if already_liked?

    flash[:notice] = "You can't like more than once"
  redirect_to cars_url
	end
end
end
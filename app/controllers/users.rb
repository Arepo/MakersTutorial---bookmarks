get '/users/new' do
	@user = User.new
	erb :"users/new"
	# note the view is in views/users/new.erb
  # we need the quotes because otherwise
  # ruby would divide the symbol :users by the
  # variable new (which makes no sense)
end

post '/users' do
	@user = User.new(email: params[:email],
				password: params[:password],
				password_confirmation: params[:password_confirmation])
	# we just initialize the object
  # without saving it. It may be invalid
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
		  # let's try saving it
  # if the model is valid,
  # it will be saved
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
		 # if it's not valid,
    # we'll show the same
    # form again
	end
end

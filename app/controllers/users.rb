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

post '/users/reset_password' do
	email = params[:email_reset]
	User.first(email: email).generate_token
	"You've been sent an email with a link to reset your password"
end

get '/users/reset_password' do
	@user = User.first(password_token: params[:token])
	if Time.now - @user.password_token_timestamp < 3600
		erb :new_password
	else
		"Sorry #{@user.email}, your reset link has expired. Would you like to request a new one?"
	end
end

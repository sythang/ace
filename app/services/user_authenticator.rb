class UserAuthenticator
	attr_reader :user, :message

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
   	@user = User.student.find_by(email: @email)
    if @user && user.valid_password?(@password)
    	@user.generate_api_token
    	unless @user.save
    		@message = @user.errors.full_messages[0]
    		false
    	end
      true
    else
    	@message = "Email or Password is incorrect"
      false
    end
  end
end
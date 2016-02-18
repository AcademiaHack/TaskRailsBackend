class UsersController < ApplicationController


  def create
    @user = User.new user_params

    unless @user.save
      @messages = @user.errors.full_messages
      render status: :conflict, template: 'layouts/errors'
    end
  end

  def access
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      payload = {data: user.email}
      @user = {
          token: JWT.encode(payload, nil, 'none'),
          email: user.email
      }
    else
      @messages = ['InvalidUser']
      render status: :conflict, template: 'layouts/errors'
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

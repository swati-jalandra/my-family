class OmniauthCallbacksController < ApplicationController
  # github callback
  def github
    @user = User.create_from_github_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash.notice = "Signed in!"
    else
      flash[:error] = 'There was a problem signing you in through Github. Please register or try signing in later.'
      redirect_to new_user_session_url
    end
  end

  # facebook callback
  def facebook
    @user = User.create_from_facebook_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash.notice = "Signed in!"
    else
      flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      redirect_to new_user_session_url
    end
  end

  # google callback
  def google_oauth2
    @user = User.create_from_google_oauth2_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash.notice = "Signed in!"
    else
      flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_session_url
    end
  end

  # redirect to failure action in case of any issues
  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_user_session_url
  end
end

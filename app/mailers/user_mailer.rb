class UserMailer < ApplicationMailer
  default from: 'aurelie.proffit@gmail.com'
  helper :application

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Keep Running")
  end

  def new_challenge_created(challenge)
    @challenge = challenge
    mail(to: @challenge.user.email, subject: "New Challenge!")
  end
end

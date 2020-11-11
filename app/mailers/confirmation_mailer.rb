class ConfirmationMailer < ApplicationMailer

    def inform(user)

    @user = user

    sleep 5 # this is for demonstration purposes of a long page load.

    mail(
      from: 'info@rblog.com',
      to: @user.email,
      subject: "Hi #{@user.name}, welcome to rBlog!"
    )
  end
end

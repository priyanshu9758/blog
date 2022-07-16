class AccountMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_mailer.account_created.subject
  #
  def account_created
    @account = params[:account]
    @greeting = "Hi"
    attachments['Vector.png'] = File.read('app/assets/images/Vector.png')
    mail(
      from: "priyanshu@jarvis.com",
      to: @account.email,
      # cc: Account.all.pluck(:email),
      bcc: "priyanshu9758503581@gmail.com",
      subject: "New account created successfully"
    )
   end
end

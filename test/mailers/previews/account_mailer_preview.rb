# Preview all emails at http://localhost:3000/rails/mailers/account_mailer
class AccountMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/account_mailer/account_created
  def account_created

    AccountMailer.with(account: Account.last).account_created
  end

end

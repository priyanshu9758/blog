require 'test_helper'

class AccountMailerTest < ActionMailer::TestCase
  test "account_created" do
    mail = AccountMailer.account_created
    assert_equal "Account created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

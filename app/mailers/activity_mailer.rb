class ActivityMailer < ActionMailer::Base
  default from: 'digest@weareyvr.ca'
 
  def weekly_digest(user)
    @user = user
    @activities = PublicActivity::Activity.last(20).reverse
    mail(to: @user.email, subject: "Your Email Digest for #{l Date.today, format: :long}")
  end
end

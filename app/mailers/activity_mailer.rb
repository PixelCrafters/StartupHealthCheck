class ActivityMailer < ActionMailer::Base 
  def weekly_digest(user)
    @user = user
    @activities = PublicActivity::Activity.last(20).reverse
    mail(to: @user.email, subject: "Your Email Digest for #{l Date.today, format: :long}", from: "digest@weareyvr.ca")
  end
end

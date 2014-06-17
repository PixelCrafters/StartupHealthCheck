class ActivityMailer < ActionMailer::Base 
  def weekly_digest(user)
    @user = user
    @activities = filtered_activities
    mail(to: @user.email, subject: "Your Email Digest for #{l Date.today, format: :long}", from: "digest@weareyvr.ca")
  end

  private

  def filtered_activities
    PublicActivity::Activity.combined_distinct.take(20).reverse
  end
end

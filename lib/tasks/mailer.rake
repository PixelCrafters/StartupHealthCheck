namespace :mailer do
  desc "Send weely email digest"
  task send_weekly_digest: :environment do
    subscribed_users = User.where(email_digest: true)
    subscribed_users.each do |user|
      ActivityMailer.weekly_digest(user).deliver
    end
  end
end

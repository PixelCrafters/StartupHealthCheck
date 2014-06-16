namespace :mailer do
  desc "Send weely email digest"
  task send_weekly_digest: :environment do
    subscribed_users = User.where(email_digest: true)
    subscribed_users.each do |user|
      puts ENV['GMAIL_USERNAME']
      puts ENV['GMAIL_PASSWORD']
      ActivityMailer.weekly_digest(user).deliver
    end
  end
end

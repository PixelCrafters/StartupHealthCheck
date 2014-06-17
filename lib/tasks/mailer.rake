namespace :mailer do
  desc "Send weely email digest"
  task send_weekly_digest: :environment do
    subscribed_users = User.where(email_digest: true)
    subscribed_users.each do |user|
      ActivityMailer.weekly_digest(user).deliver
    end
  end

  task :send_single_weekly_digest, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    ActivityMailer.weekly_digest(user).deliver
  end
end

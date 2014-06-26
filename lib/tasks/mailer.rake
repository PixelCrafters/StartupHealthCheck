namespace :mailer do

  #TODO: make day of week configurable - currently set to Monday
  desc "Send weely email digest"
  task send_weekly_digest: :environment do
    if Time.now.monday?
      subscribed_users = User.where(email_digest: true)
      subscribed_users.each do |user|
        ActivityMailer.weekly_digest(user).deliver
      end
    end
  end

  task :send_single_weekly_digest, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    ActivityMailer.weekly_digest(user).deliver
  end
end

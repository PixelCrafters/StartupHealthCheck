require 'spec_helper'
 
describe ActivityMailer do
  describe '#weekly_digest' do
    let(:user) { FactoryGirl.build(:user, name: 'Jenn', email: 'example@email.com') }
    let(:mail) { ActivityMailer.weekly_digest(user) }
 
    it 'renders the subject' do
      expect(mail.subject).to eql('Your Email Digest for #{Date.today}')
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eql(['digest@weareyvr.ca'])
    end
  end
end

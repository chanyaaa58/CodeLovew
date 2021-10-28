require 'rails_helper'
RSpec.describe 'User Model Test', type: :model do
  describe 'user test' do
    before do
      @user = FactoryBot.create(:user1)
    end

    context 'User registration' do
      it 'fulfilled info with user create should be passed validation checks' do
        expect(FactoryBot.build(:user1)).to be_valid
      end

      it 'some blanks with columns for user in registration' do
        expect(FactoryBot.build(:user1, name: nil)).to be_invalid # name => nil
        expect(FactoryBot.build(:user1, email: nil)).to be_invalid # email => nil
        expect(FactoryBot.build(:user1, password: nil)).to be_invalid # password => nil
        expect(FactoryBot.build(:user1, name: nil, email: nil, password: nil)).to be_invalid # whole column => nil
        expect(FactoryBot.build(:user1, name: "test" * 30)).to be_invalid # character amount.
        expect(FactoryBot.build(:user1, email: ("test" * 30) + "test@test.com")).to be_invalid # character amount.
      end
    end
  end
end
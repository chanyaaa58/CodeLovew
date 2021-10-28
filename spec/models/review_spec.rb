require 'rails_helper'
RSpec.describe 'Review Model Test', type: :model do
  describe 'review test' do

    before do
      @user = FactoryBot.create(:user1)
    end
    context 'validation' do
      it 'data with fulfilled column should pass validation checks' do
        expect(FactoryBot.build(:review, user: @user)).to be_valid
      end

      it 'data with blank column will be rejected by validation.' do
        expect(FactoryBot.build(:review, title: nil, user: @user)).to be_invalid # title => nil
        expect(FactoryBot.build(:review, problem: nil, user: @user)).to be_invalid # problem => nil
        expect(FactoryBot.build(:review, detail: nil, user: @user)).to be_invalid # detail => nil
        expect(FactoryBot.build(:review, content: nil, user: @user)).to be_invalid# content => nil
        expect(FactoryBot.build(:review, title: nil, detail: nil, user: @user)).to be_invalid # multiple columns => nil
        expect(FactoryBot.build(:review, detail: "detail" * 1_000, user: @user)).to be_invalid # detail string exceeds 3000
        expect(FactoryBot.build(:review, content: "test" * 1_000, user: @user)).to be_invalid # content string exceeds 3000
        expect(FactoryBot.build(:review, problem: "test" * 1_000, user: @user)).to be_invalid # problem string exceeds 3000
      end
    end
  end
end
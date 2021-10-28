require 'rails_helper'
RSpec.describe 'Review Model Test', type: :model do
  describe 'review test' do

    before do
      @user = FactoryBot.create(:user1)
      @review = FactoryBot.create(:review, user: @user)
    end
    context 'validation' do
      it 'data with fulfilled column should pass validation checks' do
        expect(FactoryBot.build(:comment, content: "test_comment", review: @review, user: @user)).to be_valid
      end

      it 'data with blank column will be rejected by validation.' do
        expect(FactoryBot.build(:comment, content: "test_comment" * 20, review: @review, user: @user)).to be_invalid
      end
    end
  end
end
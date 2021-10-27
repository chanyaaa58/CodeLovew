require 'rails_helper'

RSpec.describe 'お気に入り登録機能', type: :system do

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'user1@email.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
  end

  before do
    @user1 = FactoryBot.create(:user1)
    @user2 = FactoryBot.create(:user2)
    FactoryBot.create(:review, title: 'お気に入り確認用1', user: @user2)
    @review = FactoryBot.create(:review, title: 'お気に入り確認用2', user: @user1)
    Lovew.create(user_id: @user1.id, review_id: @review.id)
  end

  describe 'お気に入り登録のテスト' do
    before do
      login
    end
    context 'レビューのお気に入り確認' do
      it 'マイページで確認できる' do
        visit reviews_path
        expect(@user1.lovews.count).to eq 1
        expect(@user1.lovews[0].review.title).to eq 'お気に入り確認用2'
        find('.unheart').click
        all('.heart')[0].click
        visit user_path(id: @user1.id)
        expect(page).to have_content 'お気に入り確認用1'
      end
    end


  end
end
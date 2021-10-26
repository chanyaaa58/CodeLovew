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
    FactoryBot.create(:review, user: @user1)
    @review = FactoryBot.create(:review, user: @user1)
    Lovew.create(user_id: @user1.id, review_id: @review.id)
  end

  describe 'お気に入り登録のテスト' do
    before do
      login
    end
    context 'レビューをお気に入りした場合' do
      it 'マイページで確認できる' do
        visit reviews_path
        click_link '0'
        visit user_path(id: @user1.id)
        expect(page).to have_content 'My Page'
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'user1@email.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
  end

  describe '​ユーザー登録のテスト​' do
    context '​ユーザーが登録操作をした場合​' do
      it '​ユーザーの新規登録ができる​' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user1@email.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign in'
        expect(page).to have_content 'ALL Reviews'
      end

      context '​ユーザーが登録操作をした場合​' do
        it '​投稿一覧画面に飛ぼうとした時、ログイン画面に遷移する' do
          visit reviews_path
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe 'ログイン機能のテスト' do
    context '登録済のユーザーがログイン画面で正しい入力をした場合' do
      before do
        FactoryBot.create(:user1)
      end
      it 'ログインに成功し、投稿一覧画面に遷移する' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'user1@email.com'
        fill_in 'user[password]', with: 'password'
        click_button 'Log in'
        expect(page).to have_content 'ALL Reviews'
      end
    end

    context 'ユーザーがログインしている場合' do
      before do
        @user1 = FactoryBot.create(:user1)
        @user2 = FactoryBot.create(:user2)
        login
      end
      it 'ログアウトができること' do
        click_link 'Log Out'
        expect(page).to have_content 'ログアウトしました。'
      end
      it '他人のマイページに飛ぼうとすると、自分のマイページに遷移する' do
        visit user_path(@user2)
        expect(page).to have_content '権限がありません'
      end
    end
  end

  describe 'ユーザー編集機能' do
    context 'ユーザーが編集操作をした場合' do
      before do
        @user1 = FactoryBot.create(:user1)
        login
      end
      it 'ユーザー情報の編集画面から編集ができ、マイページへ遷移する' do
        visit edit_user_registration_path(id: @user1.id)
        fill_in 'user[name]', with: 'user_edit'
        fill_in 'user[current_password]', with: 'password'
        click_button 'Confirm!'
        expect(page).to have_content 'プロフィールを編集しました。'
      end
    end
  end

  describe 'ユーザー削除機能' do
    context 'ユーザーがアカウント削除操作をした場合' do
      before do
        @user1 = FactoryBot.create(:user1)
        login
      end
      it 'アカウントが削除できる' do
        visit user_path(id: @user1.id)
        click_link 'Delete'
        click_link 'Yes'
        sleep 2.0
        expect(page).to have_content '退会処理が完了いたしました。ご利用いただきありがとうございました！'
      end
    end
  end

  describe 'ゲストログイン機能' do
    context '管理者ゲストログインをした場合' do
      it 'ログインができ、管理画面に遷移する' do
        visit root_path
        click_link 'Admin Guest Log In'
        expect(page).to have_content 'サイト管理'
      end
    end
    context 'ゲストログインをした場合' do
      it 'ログインができ、投稿一覧画面に遷移する' do
        visit root_path
        click_link 'Guest Log In'
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'レビュー投稿機能', type: :system do

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'user1@email.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
  end

  before do
    @user1 = FactoryBot.create(:user1)
    @user2 = FactoryBot.create(:user2)
    @label1 = FactoryBot.create(:label1)
    # @label2 = FactoryBot.create(:label2)
    FactoryBot.create(:review, user: @user1)#, label: @label1)
    FactoryBot.create(:second_review,  user: @user2)#, label: @label2)
    @review = FactoryBot.create(:review, user: @user1)#, label: @label1)
    @second_review = FactoryBot.create(:second_review, user: @user2)#, label: @label2)
  end

  describe 'CRUD機能のテスト' do
    before do
      login
    end
    context '新規投稿した場合' do
      it '登録され、投稿一覧ページに遷移する' do
        visit new_review_path
        fill_in 'review[title]', with: 'test_title'
        fill_in 'review[problem]', with: 'test_problem'
        fill_in 'review[detail]', with: 'test_detail'
        fill_in 'review[solution]', with: 'test_solution'
        fill_in 'review[content]', with: 'test_content'
        click_button 'Confirm!'
        expect(page).to have_content 'レビューを投稿しました。'
        expect(page).to have_content 'ALL Reviews'
      end
    end

    context '投稿を編集した場合' do
      it '編集・更新され、投稿一覧ページに遷移する' do
        visit edit_review_path(id: @review.id)
        fill_in 'review[title]', with: 'edit_title'
        fill_in 'review[problem]', with: 'test_problem'
        fill_in 'review[detail]', with: 'test_detail'
        fill_in 'review[solution]', with: 'test_solution'
        fill_in 'review[content]', with: 'test_content'
        click_button 'Confirm!'
        expect(page).to have_content '投稿を更新しました。'
        expect(page).to have_content 'ALL Reviews'
      end
    end

    context '投稿を削除した場合' do
      it '削除され、投稿一覧画面に遷移する' do
        visit review_path(id: @review.id)
        click_link 'Delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '投稿を削除しました。'
        expect(page).to have_content 'ALL Reviews'
      end
    end
  end

  describe '検索機能のテスト' do
    before do
      login
      visit reviews_path
    end
    context 'タグ検索をした場合' do
      it 'その検索したタグが紐付いた検索結果のみが表示される' do
        binding.irb
        select 'label1', from: 'review[label_ids]'
        find('#non-gem').click
        expect(page).to have_content 'label1'
        expect(page).to have_no_content 'おそい'
      end
    end

    context 'キーワード検索をした場合' do
      it 'その検索したキーワードのあいまい検索の結果が表示される' do
        fill_in 'q[title_or_problem_or_detail_or_solution_or_content_cont]', with: 'test_problem'
        find('#ransack').click
        expect(page).to have_content 'test_problem'
        expect(page).to have_no_content 'ねむい'
      end
    end

    context 'キーワード検索で該当する検索がない場合' do
      it '検索結果ページに推移し、投稿が1件も表示されない' do
        fill_in 'q[title_or_problem_or_detail_or_solution_or_content_cont]', with: 'さむい'
        find('#ransack').click
        expect(page).to have_content '検索結果は0件です。'
      end
    end
  end
end
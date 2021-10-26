require 'rails_helper'

RSpec.describe 'タグ管理機能', type: :system do

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
    @label2 = FactoryBot.create(:label2)
    @review = FactoryBot.create(:review, user: @user1)
    @second_review = FactoryBot.create(:second_review, user: @user2)
    Labelling.new(label_id: @label1.id, review_id: @review.id)
  end

  describe 'タグ追加機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクにタグを付けられる' do
        login
        visit new_review_path
        fill_in 'review[title]', with: 'test_title'
        fill_in 'review[problem]', with: 'test_problem'
        fill_in 'review[detail]', with: 'test_detail'
        fill_in 'review[solution]', with: 'test_solution'
        fill_in 'review[content]', with: 'test_content'
        check "review_label_ids_#{(@label1.id)}"
        click_button 'Confirm!'
        expect(page).to have_content 'label1'
      end
    end
  end

  describe 'タグ追加機能' do
    context 'タグ検索をした場合' do
      it '検索したラベルが紐づいているレビューが表示される' do
        login
        visit reviews_path
        select 'label1', from: 'label_id'
        find('#non-gem').click
        expect(page).to have_content 'label1'
      end
    end
  end
end
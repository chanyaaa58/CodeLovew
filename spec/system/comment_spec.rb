require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do

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
    Comment.create(user_id: @user2.id, review_id: @review.id, content: "@user2のコメント確認用content")
    Comment.create(user_id: @user1.id, review_id: @review.id, content: "@user1のコメント確認用content")
  end

  describe 'CRUD機能のテスト' do
    context '新規コメントをした場合' do
      it '登録されたコメントが表示される' do
        login
        visit review_path(id: @review.id)
        fill_in "comment[content]", with: "@user1のコメント投稿"
        click_button 'Comment!'
        expect(page).to have_content '@user1のコメント投稿'
      end
    end

    context 'コメントした人がコメントを編集をしようとする場合' do
      it '編集ができる' do
        login
        visit review_path(id: @review.id)
        all('.edit_comment')[0].click
        fill_in "updating_comment", with: "updated_comment"
        click_on "Update"
        expect(page).to have_content 'updated_comment'
      end

      it '削除ができる' do
        login
        visit review_path(id: @review.id)
        find('.delete_comment').click
        page.driver.browser.switch_to.alert.accept
        expect(@user1.comments.count).to eq 1
      end
    end


    context 'コメントしていない人が編集をしようとする場合' do
      it '編集・削除ボタンが表示されない' do
        login
        Comment.second.destroy
        visit review_path(id: @review.id)
        expect(all(".review_edit").count).to eq 1 # => 現在のpageに表示されているDeleteボタンはreviewのもののみ(1つだけであること)の証明
        expect(all(".review_delete").count).to eq 1 # => 現在のpageに表示されているDeleteボタンはreviewのもののみ(1つだけであること)の証明
      end
    end
  end
end
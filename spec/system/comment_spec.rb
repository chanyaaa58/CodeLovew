# require 'rails_helper'

# RSpec.describe 'コメント編集機能', type: :system do

#   def login
#     visit new_user_session_path
#     fill_in 'user[email]', with: 'user1@email.com'
#     fill_in 'user[password]', with: 'password'
#     click_button 'Log in'
#   end

#   before do
#     @user1 = FactoryBot.create(:user1)
#     @user2 = FactoryBot.create(:user2)
#     @label1 = FactoryBot.create(:label1)
#     @label2 = FactoryBot.create(:label2)
#     @review = FactoryBot.create(:review, user: @user1)
#     @second_review = FactoryBot.create(:second_review, user: @user2)
#     Comment.create(user_id: @user2.id, review_id: @review.id, content: "test")
#   end

#   describe 'CRUD機能のテスト' do
#     before do
#       login
#     end
#     context '新規コメントをした場合' do
#       it '登録され、ページ遷移をしない' do
#         visit review_path(id: @review.id)
#         click_button 'Comment!'
#         expect(page).to_not have_content 'ALL Reviews'
#       end


#     context 'コメントした人が編集をしようとする場合' do
#       it '編集・削除ボタンが表示される' do
#         visit review_path(id: @review.id)

#       end


#     context 'コメントしていない人が編集をしようとする場合' do
#       it '編集・削除ボタンが表示されない' do
#         visit review_path(id: @review.id)
#       end
#     end
# end
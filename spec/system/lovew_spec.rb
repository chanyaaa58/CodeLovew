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
      it 'お気に入り削除した投稿がマイページから消え,新しくお気に入りした投稿がマイページで新たに表示される' do
        visit reviews_path
        expect(@user1.lovews.count).to eq 1 # このテスト開始時にUserが既にお気に入りしているreviewが1件あること
        expect(@user1.lovews[0].review.title).to eq 'お気に入り確認用2' #上記にて既にお気に入りしている投稿のタイトルが'お気に入り確認用2'であること
        find('.unheart').click # 最初からお気に入りしてある上記投稿のお気に入り解除をしている => お気に入り削除機能の証明
        all('.heart')[0].click # もう１件の投稿をお気に入りする => お気に入り登録機能の証明
        visit user_path(id: @user1.id) # userのshowに移動
        expect(page).to have_content 'お気に入り確認用1' # 最後にお気に入りしたもう１件の投稿がお気に入り一覧に表示されていることの証明
      end
    end


  end
end
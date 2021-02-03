RSpec.describe "Profile_show", type: :request do
  describe "GET users_show_path" do

    let(:user) { create(:user) }
    let(:user2) { create(:user2) }
    let!(:post) { create(:post, user_id: user.id) }
  
    before do
      sign_in user
      get users_show_path(user_id: user.id)
    end

    context 'プロフィール画面を見る時' do
      
      it '画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it 'ユーザーイメージが表示されること' do
        expect(response.body).to include(user.image.url)
      end

      it 'ユーザーの名前が表示されること' do
        expect(response.body).to include(user.name)
      end

      it 'ユーザーのプロフィールが表示されること' do
        expect(response.body).to include(user.profile)
      end

      it '「フォロー中」というキーワードが表示されること' do
        expect(response.body).to include("フォロー中")
      end

      it '「フォロワー」というキーワードが表示されること' do
        expect(response.body).to include("フォロワー")
      end

      it '「編集」というキーワードが表示されること' do
        expect(response.body).to include("編集")
      end

      it '「フォロワーの投稿」というキーワードが表示されること' do
        expect(response.body).to include("フォロワーの投稿")
      end

      it '「あなたの投稿一覧」というキーワードが表示されること' do
        expect(response.body).to include("あなたの投稿一覧")
      end

      it '「いいね一覧」というキーワードが表示されること' do
        expect(response.body).to include("いいね一覧")
      end

      it '自身の投稿が表示されること' do
        expect(response.body).to include(post.title)
      end

    end

  end
end

RSpec.describe "Post_create", type: :request do
  describe "GET new_post_path" do

    let(:user) { create(:user) }

    before do
      sign_in user
      get new_post_path
    end

    context '投稿作成画面を表示した時' do

      it '投稿作成画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it '「投稿タイトル」というキーワードが表示されること' do
        expect(response.body).to include("投稿タイトル")
      end

      it '「投稿内容」というキーワードが表示されること' do
        expect(response.body).to include("投稿内容")
      end

      it '「タグ」というキーワードが表示されること' do
        expect(response.body).to include("タグ")
      end

      it '「画像」というキーワードが表示されること' do
        expect(response.body).to include("画像")
      end

      it '「投稿する」というキーワードが表示されること' do
        expect(response.body).to include("投稿する")
      end
    end

  end

end

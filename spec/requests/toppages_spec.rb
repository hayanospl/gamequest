RSpec.describe "TopPages", type: :request do
  describe "GET root_path" do
#ホーム画面のテスト
    context 'root_pathを取得した時' do
      
      before do
        @post = create(:post)
        get root_path
      end

      it 'ホーム画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it 'ホーム画面に「投稿一覧」というキーワードが表示されること' do
        expect(response.body).to include("投稿一覧")
      end

      it '投稿一覧に投稿者の名前が表示されること' do
        expect(response.body).to include(@post.user.name)
      end

      it '投稿一覧に投稿タイトルが表示されること' do
        expect(response.body).to include(@post.title)
      end

      it '投稿一覧にタグが表示されること' do
        expect(response.body).to include(@post.tag_list[0])
      end

      it '投稿一覧に投稿本文が表示されていないこと' do
        expect(response.body).not_to include(@post.content)
      end

      it '投稿一覧に投稿画像が表示されていないこと' do
        expect(response.body).not_to include(@post.image.url)
      end
    end

  end

end

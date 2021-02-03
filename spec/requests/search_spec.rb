RSpec.describe "Search", type: :request do
  describe "GET posts_path" do

    let!(:post) { create(:post) }

    before do
      get posts_path
    end

    context '検索画面を表示した時' do

      it '検索画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it 'キーワード検索と表示されること' do
        expect(response.body).to include("キーワード検索")
      end

      it 'タグ検索と表示されること' do
        expect(response.body).to include("タグ検索")
      end

      it 'いいねの数と表示されること' do
        expect(response.body).to include("いいねの数を入力")
      end

      it '検索と表示されること' do
        expect(response.body).to include("検索")
      end

      it 'ホーム画面に「投稿一覧」というキーワードが表示されること' do
        expect(response.body).to include("投稿一覧")
      end

      it '投稿一覧に投稿者の名前が表示されること' do
        expect(response.body).to include(post.user.name)
      end

      it '投稿一覧に投稿タイトルが表示されること' do
        expect(response.body).to include(post.title)
      end

      it '投稿一覧にタグが表示されること' do
         expect(response.body).to include(post.tag_list[0])
      end

      it '投稿一覧に投稿本文が表示されていないこと' do
        expect(response.body).not_to include(post.content)
      end

      it '投稿一覧に投稿画像が表示されていないこと' do
        expect(response.body).not_to include(post.image.url)
      end
    end

  end

  describe "キーワード検索のテスト" do
    context 'postを5つ用意し、1番目のpostのタイトルでキーワード検索する時' do
      
      let(:post) { create_list(:post, 5) }
      
      before do
       get posts_path(keyword: "#{post[0].title}")
      end
     
      it '1番目に生成されたpostが表示されている' do
        expect(response.body).to include("#{post[0].title}")
      end

      it '2番目に生成されたpostは表示されていない' do
        expect(response.body).not_to include("#{post[1].title}")
      end

      it '3番目に生成されたpostは表示されていない' do
        expect(response.body).not_to include("#{post[2].title}")
      end

      it '4番目に生成されたpostは表示されていない' do
        expect(response.body).not_to include("#{post[3].title}")
      end

      it '5番目に生成されたpostは表示されていない' do
        expect(response.body).not_to include("#{post[4].title}")
      end
    end

  end

end

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
    context '1~5のキーワードを含むpostをそれぞれ用意し、キーワード3で検索する時' do
      
      before do
        post = []
        5.times do |i|
          post << create(:post, title: "#{i}のテスト")
        end
        get posts_path(keyword: "3")
      end
     
      it '1を含むpostは表示されない' do
        expect(response.body).not_to include("1のテスト")
      end

      it '2を含むpostは表示されない' do
        expect(response.body).not_to include("2のテスト")
      end

      it '3を含むpostは表示される' do
        expect(response.body).to include("3のテスト")
      end

      it '4を含むpostは表示されない' do
        expect(response.body).not_to include("4のテスト")
      end

      it '5を含むpostは表示されない' do
        expect(response.body).not_to include("5のテスト")
      end
    end

  end

end

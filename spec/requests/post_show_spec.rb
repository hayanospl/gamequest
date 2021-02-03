RSpec.describe "Post_show", type: :request do
  describe "GET post_path" do

    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let!(:comment) { create(:comment, post_id: post.id) }

    before do
      sign_in user
      get post_path(post.id)
    end

    context 'ユーザーが自分の投稿を見る時' do

      it '画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it 'タグが表示されること' do
        expect(response.body).to include(post.tag_list[0])
      end

      it 'タイトルが表示されること' do
        expect(response.body).to include(post.title)
      end
      
      it '「コメント」のテキストが表示されること' do
        expect(response.body).to include("コメント")
      end

      it '投稿者の名前が表示されること' do
        expect(response.body).to include(post.user.name)
      end

      it '投稿内容が表示されること' do
        expect(response.body).to include(post.content)
      end

      it '投稿画像が表示されること' do
        expect(response.body).to include(post.image.url)
      end

      it '削除が表示されること' do
        if post.user.id == user.id
          expect(response.body).to include("削除")
        end
      end

      it 'コメントが表示されること' do
        expect(response.body).to include(comment.content)
      end
    end

    context '他のユーザーが他人の投稿を見る時' do
      it '削除が表示されないこと' do
        sign_out user
        user2 = create(:user2)
        sign_in user2
        get post_path(post.id)
        expect(response.body).not_to include("削除")
      end
    end

  end

end

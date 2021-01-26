RSpec.describe "Sessions", type: :request do
  describe "GET root_path" do
#ホーム画面のテスト
    context 'ホームボタンを押した時' do
      it 'ホーム画面の表示に成功すること' do
        get root_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ホームボタンを押した時' do
      it 'ホーム画面に「投稿一覧」というキーワードが表示されること' do
        get root_path
        expect(response.body).to include("投稿一覧")
      end
    end

  end

end

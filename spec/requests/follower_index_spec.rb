RSpec.describe "Following_index", type: :request do
  describe "GET users_relationships_followers_path" do

    let(:user) { create(:user) }
    let(:relationship) { create(:relationship) }

    context 'フォロー一覧画面を表示した時' do

      before do
        sign_in user
        get users_relationships_followers_path
      end

      it 'フォロー一覧画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it '「フォローされているユーザー」というキーワードが表示されること' do
        expect(response.body).to include("フォローされているユーザー")
      end
    end

  end
end

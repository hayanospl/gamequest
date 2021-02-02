RSpec.describe "Profile_edir", type: :request do
  describe "GET users_edit_path" do

    let(:user) { create(:user) }

    before do
      sign_in user
      get users_edit_path
    end

    context 'プロフィール画面を見る時' do

      it '画面の表示に成功すること' do
        expect(response).to have_http_status(200)
      end

      it '「プロフィール編集」というキーワードが表示されること' do
        expect(response.body).to include("プロフィール編集")
      end

      it 'ユーザーイメージが表示されること' do
        expect(response.body).to include(user.image.url)
      end

      it '「ユーザーネーム」というキーワードが表示されること' do
        expect(response.body).to include("ユーザーネーム")
      end

      it 'ユーザーの名前が表示されること' do
        expect(response.body).to include(user.name)
      end

      it '「プロフィール」というキーワードが表示されること' do
        expect(response.body).to include("プロフィール")
      end

      it 'ユーザーのプロフィールが表示されること' do
        expect(response.body).to include(user.profile)
      end

      it '「画像」というキーワードが表示されること' do
        expect(response.body).to include("画像")
      end

      it '「編集する」というキーワードが表示されること' do
        expect(response.body).to include("編集する")
      end
    end


  end
end

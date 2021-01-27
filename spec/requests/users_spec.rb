RSpec.describe "Users", type: :request do
  #新規登録、ログインのテスト
  describe "GET users_create_path" do

    context 'users_create_pathを受け取った時' do
        it '新規登録画面の表示に成功すること' do
          get users_create_path
          expect(response).to have_http_status(200)
        end

        it '新規登録画面に「新規登録」が表示されていること' do
          get users_create_path
          expect(response.body).to include('新規登録')
        end
      end

    end

  describe "POST user_create_path" do

    before do
      @user = attributes_for(:user)
      @user_name_nil = attributes_for(:user, name: nil)
    end

    context '適切な情報を入力してuser_registration_pathを送信した時' do

      it 'ユーザーの作成に成功すること' do
        expect{ post user_registration_path(user: @user) }.to change(User, :count).by(1)
      end

      it 'フラッシュメッセージが表示されること' do
        post user_registration_path(user: @user)
        expect(flash[:notice]).to eq "新規登録が完了しました。"
      end

      it 'ホーム画面に移ること' do
        post user_registration_path(user: @user)
        expect(response).to redirect_to root_path
      end
    end

    context 'Nameがnilの状態でuser_registration_pathを送信した時' do

      it 'ユーザーが作成されず、200レスポンスを返すこと' do
        post user_registration_path(user: @user_name_nil)
        expect(response).to have_http_status(200)
      end

      it 'ユーザーが作成されず、エラーメッセージを返すこと' do
        post user_registration_path(user: @user_name_nil)
        expect(response.body).to include("Nameを入力してください")
      end

    end

    context 'メールアドレスがnilの状態でuser_registration_pathを送信した時' do
      it 'ユーザーが作成されず、200レスポンスを返すこと' do
        user = attributes_for(:user, email: nil)
        post user_registration_path(user: user)
        expect(response).to have_http_status(200)
      end
    end

    context 'パスワードがnilの状態でuser_registration_pathを送信した時' do
      it 'ユーザーが作成されず、200レスポンスを返すこと' do
        user = attributes_for(:user, password: nil)
        post user_registration_path(user: user)
        expect(response).to have_http_status(200)
      end
    end

  end


  describe "GET login_path" do

    context 'login_pathを取得した時' do
      it 'ログイン画面の表示に成功すること' do
        get login_path 
        expect(response).to have_http_status(200)
      end

      it 'ログイン画面に「ログイン」が表示されていること' do
        get login_path
        expect(response.body).to include('ログイン')
      end
    end

  end

  describe "POST user_session_path" do
    before do
      @user = create(:user)
    end

    context '適切な情報を入力してuser_session_pathを送信した時' do

      it 'ログインに成功すること' do
        post user_session_path(user: {email: @user.email, password: @user.password} )
        expect(response).to have_http_status(302)
      end

      it 'フラッシュメッセージが表示されること' do
        post user_session_path(user: {email: @user.email, password: @user.password} )
        expect(flash[:notice]).to eq "ログインしました。"
      end
    end

    context 'パスワードを入力せずuser_session_pathを送信した時' do

      it 'ログインに失敗し、200レスポンスを返すこと' do
        post user_session_path(user: {email: @user.email, password: nil} )
        expect(response).to have_http_status(200)
      end

      it 'ログインに失敗し、適切なエラーメッセージがでる' do
        post user_session_path(user: {email: @user.email, password: nil} )
        expect(flash[:alert]).to eq "Eメールまたはパスワードが違います。"
      end
    end

    context 'メールアドレスを入力せずuser_session_pathを送信した時' do

      it 'ログインに失敗し、200レスポンスを返すこと' do
        post user_session_path(user: {email: nil, password: @user.password} )
        expect(response).to have_http_status(200)
      end

      it 'ログインに失敗し、適切なエラーメッセージがでる' do
        post user_session_path(user: {email: nil, password: @user.password} )
        expect(flash[:alert]).to eq "Eメールまたはパスワードが違います。"
      end
    end

  end
end

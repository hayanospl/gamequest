RSpec.describe "Users create", type: :system do

  let(:user) { create(:user) }
  
    describe 'ユーザー新規登録' do

      before do
        visit users_create_path
      end

      context 'フォームの入力値が正常な時' do
        it 'ユーザーの新規作成が成功' do
          fill_in 'Name', with: 'new_commer'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq root_path
          expect(page).to have_content '新規登録が完了しました'
        end
      end

      context '名前が未記入の時' do
        it 'ユーザーの新規作成が失敗' do
          fill_in 'Name', with: nil
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq '/users'
          expect(page).to have_content 'Nameを入力してください'
        end
      end

      context 'メールアドレスが未記入の時' do
        it 'ユーザーの新規作成が失敗' do
          fill_in 'Name', with: 'new_commer'
          fill_in 'Eメール', with: nil
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq '/users'
          expect(page).to have_content 'Eメールを入力してください'
        end
      end

      context '登録済みメールアドレスの時' do
        it 'ユーザーの新規作成が失敗' do
          fill_in 'Name', with: 'new_commer'
          fill_in 'Eメール', with: user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq '/users'
          expect(page).to have_content 'Eメールはすでに存在します'
        end
      end

      context 'パスワード（確認用）が未記入の時', js: true do
        it 'ユーザーの新規作成が失敗' do
          fill_in 'Name', with: 'new_commer'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: nil
          click_button '新規登録'
          expect(current_path).to eq '/users'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end

  end

end

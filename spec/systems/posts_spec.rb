RSpec.describe "Post show", type: :system, js: true do

  let!(:user2) { create(:user2) }
  let(:post) { create_list(:post, 5) }
  
    describe '投稿詳細画面' do

      before do
        visit login_path
        fill_in 'Eメール', with: user2.email
        fill_in 'パスワード', with: user2.password
        click_button 'ログイン'
        visit post_path(post[0].id)
      end

      context 'タグリンクを押した時' do
        it 'トップページにタグを含む投稿のみがある' do
          within("div.post-show-tag") do
            click_link "#{ post[0].tag_list }"
          end
          expect(current_path).to eq root_path
          expect(page).to have_link "#{ post[0].tag_list }"
          1.upto(4) do |n|
            expect(page).not_to have_link "#{ post[n].tag_list }"
          end
        end
      end

      context 'フォローボタンを押した時' do
        it 'フォローできる' do
          within("div.post-show-container") do
            expect{ click_button 'フォロー' }.to change{ Relationship.count }.by(1)
            expect(page).to have_button 'フォロー解除'
          end
        end
      end

      context 'フォロー解除ボタンを押した時' do
        it 'フォロー解除できる' do
          within("div.post-show-container") do
            click_button 'フォロー'
            expect{ click_button 'フォロー解除' }.to change{ Relationship.count }.by(-1)
            expect(page).to have_button 'フォロー'
          end
        end
      end

      context 'テキストのみでコメントした時' do
        it '投稿詳細画面に反映される' do
          within("div.comment-container") do
            fill_in 'comment_content', with: 'a'*100
            expect{ click_button 'コメントする' }.to change{ Comment.count }.by(1)
            expect(current_path).to eq post_path(post[0].id)
          end
          expect(page).to have_content('a'*100)
        end
      end

      context 'テキストと画像でコメントした時' do
        it '投稿詳細画面に反映される' do
          within("div.comment-container") do
            fill_in 'comment_content', with: 'a'*100
            attach_file "comment_image", "#{Rails.root}/app/assets/images/sansen.png", make_visible: true
            expect{ click_button 'コメントする' }.to change{ Comment.count }.by(1)
            expect(current_path).to eq post_path(post[0].id)
          end
          expect(page).to have_selector("img[src$='#{post[0].comments[0].image.url}']")
        end
      end

      context '何も入力せずにコメントした時' do
        it '投稿詳細画面に反映されない' do
          within("div.comment-container") do
            expect{ click_button 'コメントする' }.to change{ Comment.count }.by(0)
            expect(current_path).to eq post_path(post[0].id)
          end
        end
      end

      context '画像のみでコメントした時' do
        it '投稿詳細画面に反映されない' do
          within("div.comment-container") do
            attach_file "comment_image", "#{Rails.root}/app/assets/images/sansen.png", make_visible: true
            expect{ click_button 'コメントする' }.to change{ Comment.count }.by(0)
            expect(current_path).to eq post_path(post[0].id)
          end
        end
      end

      context '自分が投稿したコメントの削除ボタンを押した時' do
        it 'コメントが削除される' do
          within("div.comment-container") do
            fill_in 'comment_content', with: 'a'*100
            expect{ click_button 'コメントする' }.to change{ Comment.count }.by(1)
          end
          within("div.post-delete") do
            expect{ click_on '削除' }.to change{ Comment.count }.by(-1)
            expect(current_path).to eq post_path(post[0].id)
          end
        end
      end

      context '投稿のいいねボタンをクリックした時' do
        it 'いいねできる' do
          within("div#likes_buttons_#{post[0].id}") do
            expect{ find('.far').click }.to change{ Like.count }.by(0)
            expect{ visit current_path }.to change{ Like.count }.by(1)
            expect(page).to have_css '.fas'
          end
          expect(page).to have_css "div#likes_buttons_#{post[0].id}", text: '1'
        end
      end

      context '投稿のいいねボタンを削除した時' do
        it 'いいねが削除される' do
          within("div#likes_buttons_#{post[0].id}") do
            find('.far').click
            visit current_path
            expect{ find('.fas').click }.to change{ Like.count }.by(0)
            expect{ visit current_path }.to change{ Like.count }.by(-1)
            expect(page).to have_css '.far'
          end
          expect(page).to have_css "div#likes_buttons_#{post[0].id}", text: '0'
        end
      end

    end

  end

RSpec.describe User, type: :model do
  describe '名前、メール、パスワードの有無' do

    context '適切な名前、メール、パスワードがある時' do
      it '有効である' do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context '名前が無い時' do
      it '無効である' do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors.full_messages).to eq ["Nameを入力してください"]
      end
    end

    context 'メールが無い時' do
      it '無効である' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors.full_messages).to eq ["Eメールを入力してください"]
      end
    end

    context 'パスワードが無い時' do
      it '無効である' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors.full_messages).to eq ["パスワードを入力してください"]
      end
    end

  end

  describe 'メールのvalidationの確認' do

    context '一文字の時' do
      it '無効である' do
        user = build(:user, email: "a")
        user.valid?
        expect(user.errors.full_messages).to eq ["Eメールは不正な値です"]
      end
    end

    context '一文字+@の時' do
        it '無効である' do
        user = build(:user, email: "a@")
        user.valid?
        expect(user.errors.full_messages).to eq ["Eメールは不正な値です"]
      end
    end

    context '一文字+@+一文字の時' do
      it '有効である' do
        user = build(:user, email: "a@a")
        user.valid?
        expect(user).to be_valid
      end
    end

  end


  describe 'パスワードの文字数の確認' do

    context 'パスワードが129文字の時' do
      it '無効である' do
        user = build(:user, password: "a"*129 )
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'パスワードが128文字の時' do
      it '有効である' do
      user = build(:user, password: "a"*128 )
      expect(user).to be_valid
      end
    end

    context 'パスワードが6文字の時' do
      it '有効である' do
        user = build(:user, password: "a"*6 )
      expect(user).to be_valid
      end
    end
    
    context 'パスワードが5文字の時' do
      it '無効である' do
        user = build(:user, password: "a"*5 )
        user.valid?
        expect(user.errors.full_messages).to eq ["パスワードは6文字以上で入力してください"]
      end
    end

  end

  describe 'ユーザー削除の確認' do

    context 'ユーザーが削除された時' do
      it 'ユーザーレコードが無くなる' do
        user = create(:user)
        expect { user.destroy }.to change { User.count }.by(-1)
      end
    end

    context 'ユーザーが削除された時' do
      it 'ユーザーに紐づくポストが無くなる' do
        post = create(:post)
        expect { User.find(post.user_id).destroy }.to change { Post.count }.by(-1)
      end
    end

    context 'ユーザーが削除された時' do
      it 'ユーザーに紐づくポストに紐づくいいねが無くなる' do
        like = create(:like)
        expect { User.find(like.user_id).destroy }.to change { Like.count }.by(-1)
      end
    end

    context 'ユーザーが削除された時' do
      it 'ポストに紐づくコメントが無くなる' do
        comment = create(:comment)
        expect { User.find(comment.user_id).destroy }.to change { Comment.count }.by(-1)
      end
    end

    context 'ユーザーが削除された時' do
      it 'コメントに紐づくいいねが無くなる' do
        commentlike = create(:commentlike)
        expect { User.find(commentlike.user_id).destroy }.to change { CommentLike.count }.by(-1)
      end
    end

    context 'フォローするユーザーが削除された時' do
      it 'relationshipが無くなる' do
        relationship = create(:relationship)
        expect { User.find(relationship.user_id).destroy }.to change { Relationship.count }.by(-1)
      end
    end

    context 'フォローされるユーザーが削除された時' do
      it 'relationshipが無くなる' do
        relationship = create(:relationship)
        expect { User.find(relationship.follow_id).destroy }.to change { Relationship.count }.by(-1)
      end
    end

  end



end

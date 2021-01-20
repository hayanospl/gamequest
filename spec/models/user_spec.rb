require 'rails_helper'
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
        expect(user.errors[:name]).to eq ["を入力してください"]
      end
    end

    context 'メールが無い時' do
      it '無効である' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to eq ["を入力してください"]
      end
    end

    context 'パスワードが無い時' do
      it '無効である' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to eq ["を入力してください"]
      end
    end

  end

  describe 'メールのvalidationの確認' do

    context '一文字の時' do
      it '無効である' do
        user = build(:user, email: "a")
        user.valid?
        expect(user.errors[:email]).to eq ["は不正な値です"]
      end
    end

    context '一文字+@の時' do
        it '無効である' do
        user = build(:user, email: "a@")
        user.valid?
        expect(user.errors[:email]).to eq ["は不正な値です"]
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
        expect(user.errors[:password]).to eq ["は6文字以上で入力してください"]
      end
    end

  end

end

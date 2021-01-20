require 'rails_helper'
RSpec.describe User, type: :model do
  describe '名前、メール、パスワードの有無' do

    context '適切な名前、メール、パスワードがある時' do
      it '有効である' do
        user = User.new(name: "tanaka", email:"tanaka@example.com", password: "password")
        expect(user).to be_valid
      end
    end

    context '名前が無い時' do
      it '無効である' do
        user = User.new(name: nil, email:"tanaka@example.com", password: "password")
        user.valid?
        expect(user.errors[:name]).to eq ["を入力してください"]
      end
    end

    context 'メールが無い時' do
      it '無効である' do
        user = User.new(name: "tanaka", email: nil, password: "password")
        user.valid?
        expect(user.errors[:email]).to eq ["を入力してください"]
      end
    end

    context 'パスワードが無い時' do
      it '無効である' do
        user = User.new(name: "tanaka", email: "tanaka@example.com", password: nil)
        user.valid?
        expect(user.errors[:password]).to eq ["を入力してください"]
      end
    end

  end

  describe 'メールのvalidationの確認' do

    let(:user){User.new(params)}
    let(:params){{ name: "tanaka", email: email, password: "password"}}

    context '一文字の時' do
      let(:email){"a"}
      it '無効である' do
        user.valid?
        expect(user.errors[:email]).to eq ["は不正な値です"]
      end
    end

    context '一文字+@の時' do
      let(:email){"a@"}
      it '無効である' do
        user.valid?
        expect(user.errors[:email]).to eq ["は不正な値です"]
      end
    end

    context '一文字+@+一文字の時' do
      let(:email){"a@a"}
      it '有効である' do
        user.valid?
        expect(user).to be_valid
      end
    end

  end


  describe 'パスワードの文字数の確認' do

    let(:user){User.new(params)}
    let(:params){{ name: "tanaka", email: "tanaka@example.com", password: password}}
    
    context 'パスワードが129文字の時' do
      let(:password){"a"*129}
      it '無効である' do
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'パスワードが128文字の時' do
      let(:password){"a"*128}
      it '有効である' do
      expect(user).to be_valid
      end
    end

    context 'パスワードが6文字の時' do
      let(:password){"a"*6}
      it '有効である' do
      expect(user).to be_valid
      end
    end
    
    context 'パスワードが5文字の時' do
      let(:password){"a"*5}
      it '無効である' do
        user.valid?
        expect(user.errors[:password]).to eq ["は6文字以上で入力してください"]
      end
    end

  end

end

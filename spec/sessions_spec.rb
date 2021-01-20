require 'rails_helper'
RSpec.describe User, type: :model do
  describe '存在してるかどうかの確認' do
    it '名前、メール、パスワードがある時有効' do
      user = User.new(name: "tanaka", email:"tanaka@example.com", password: "password")
      expect(user).to be_valid
    end

    it '名前がない時、無効である' do
      user = User.new(name: nil, email:"tanaka@example.com", password: "password")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'メールアドレスがない時、無効である' do
      user = User.new(name: "tanaka", email: nil, password: "password")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'パスワードがない時、無効である' do
      user = User.new(name: "tanaka", email: "tanaka@example.com", password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end

  describe 'メールのvalidate、一意性、小文字大文字の確認' do

    let(:user){User.new(params)}
    let(:params){{ name: "tanaka", email: email, password: "password"}}

    context '一文字の時' do
      let(:email){"a"}
      it '無効である' do
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
    end

    context '一文字+@の時' do
      let(:email){"a@"}
      it '無効である' do
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
    end

    context '一文字+@+一文字の時' do
      let(:email){"a@a"}
      it '有効である' do
        user.valid?
        expect(user).to be_valid
      end
    end

    # context '一意性の確認' do
    #   let(:email){"test@test.test"}
    #   let(:dummyuser){User.new(params)}
    #   let(:params){{ name: "tanakadummy", email: "test@test.test", password: "passworddummy"}}
    #   it '同じメールアドレスは無効である' do
    #   dummyuser.valid?
    #   expect(dummyuser.errors[:email]).to be_invalid
    #   end
    # end

  end


  describe 'パスワードの文字数の確認' do

    let(:user){User.new(params)}
    let(:params){{ name: "tanaka", email: "tanaka@example.com", password: password}}
    
    context 'パスワードが129文字の時' do
      let(:password){"a"*129}
      it '129文字は無効である' do
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'パスワードが128文字の時' do
      let(:password){"a"*128}
      it '128文字は有効である' do
      expect(user).to be_valid
      end
    end

    context 'パスワードが6文字の時' do
      let(:password){"a"*6}
      it '6文字は有効である' do
      expect(user).to be_valid
      end
    end
    
    context 'パスワードが5文字の時' do
      let(:password){"a"*5}
      it '5文字は無効である' do
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

  end

end

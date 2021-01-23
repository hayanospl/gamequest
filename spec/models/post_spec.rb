require 'rails_helper'
RSpec.describe Post, type: :model do
  describe 'タイトル 本文 タグ 画像の有無' do

    context '適切なタイトル、本文、タグ、画像(jpg)がある時' do
      it '有効である' do
        post = build(:post)
        expect(post).to be_valid
      end
    end

    context 'タイトルが無い時' do
      it '無効である' do
        post = build(:post, title: nil)
        post.valid?
        expect(post.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context '本文が無い時' do
      it '無効である' do
        post = build(:post, content: nil)
        post.valid?
        expect(post.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context 'タグが無い時' do
      it '有効である' do
        post = build(:post, tag_list: nil)
        expect(post).to be_valid
      end
    end

    context '画像が無い時' do
      it '有効である' do
        post = build(:post, image: nil)
        expect(post).to be_valid
      end
    end

  end

  describe 'タイトルのバリデーション' do

    context 'タイトルが入力されていない時' do
      it '適切なエラーが出る' do
        post = build(:post, title: nil )
        post.valid?
        expect(post.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context 'タイトルが1文字の時' do
      it '有効である' do
        post = build(:post, title: "a"*1 )
        expect(post).to be_valid
      end
    end

    context 'タイトルが199文字の時' do
      it '有効である' do
        post = build(:post, title: "a"*199 )
        expect(post).to be_valid
      end
    end

    context 'タイトルが200文字の時' do
      it '有効である' do
        post = build(:post, title: "a"*200 )
        expect(post).to be_valid
      end
    end

    context 'タイトルで全角で200文字の時' do
      it '有効である' do
        post = build(:post, title: "あ"*200 )
        expect(post).to be_valid
      end
    end

    context 'タイトルが201文字の時' do
      it '無効である' do
        post = build(:post, title: "a"*201 )
        post.valid?
        expect(post).to be_invalid
      end
    end

    context 'タイトルが201文字の時' do
      it '適切なエラーが出る' do
        post = build(:post, title: "a"*201 )
        post.valid?
        expect(post.errors.full_messages).to eq ["タイトルは200文字以内で入力してください"]
      end
    end

  end

  describe '本文のバリデーション' do

    context '本文が入力されていない時' do
      it '適切なエラーが出る' do
        post = build(:post, content: nil )
        post.valid?
        expect(post.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context '本文が1文字の時' do
      it '有効である' do
        post = build(:post, content: "a"*1 )
        expect(post).to be_valid
      end
    end

    context '本文が1999文字の時' do
      it '有効である' do
        post = build(:post, content: "a"*1999 )
        expect(post).to be_valid
      end
    end

    context '本文が2000文字の時' do
      it '有効である' do
        post = build(:post, content: "a"*2000 )
        expect(post).to be_valid
      end
    end

    context '本文で全角で2000文字の時' do
      it '有効である' do
        post = build(:post, content: "あ"*2000 )
        expect(post).to be_valid
      end
    end

    context '本文が2001文字の時' do
      it '無効である' do
        post = build(:post, content: "a"*2001 )
        post.valid?
        expect(post).to be_invalid
      end
    end

    context '本文が2001文字の時' do
      it '適切なエラーが出る' do
        post = build(:post, content: "a"*2001 )
        post.valid?
        expect(post.errors.full_messages).to eq ["本文は2000文字以内で入力してください"]
      end
    end

  end

  describe '画像のバリデーション' do

    context '画像ファイル形式がjpgの時' do
      it '有効である' do
        post = build(:post, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg')) )
        expect(post).to be_valid
      end
    end

    context '画像ファイル形式がpngの時' do
      it '有効である' do
        post = build(:post, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sansen.png')) )
        expect(post).to be_valid
      end
    end

    context '画像ファイル形式がgifの時' do
      it '有効である' do
        post = build(:post, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/test.gif')) )
        expect(post).to be_valid
      end
    end

  end

end

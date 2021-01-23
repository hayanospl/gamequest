require 'rails_helper'
RSpec.describe Comment, type: :model do
  describe '本文 画像の有無' do

    context '適切な本文、画像(jpg)がある時' do
      it '有効である' do
        comment = build(:comment)
        expect(comment).to be_valid
      end
    end

    context 'コメントが無い時' do
      it '無効である' do
        comment = build(:comment, content: nil)
        comment.valid?
        expect(comment).to be_invalid
      end
    end

    context '画像が無い時' do
      it '有効である' do
        comment = build(:comment, image: nil)
        expect(comment).to be_valid
      end
    end

  end

  describe 'コメントのバリデーション' do

    context 'コメントが入力されていない時' do
      it '適切なエラーが出る' do
        comment = build(:comment, content: nil )
        comment.valid?
        expect(comment.errors.full_messages).to eq ["Contentを入力してください"]
      end
    end

    context 'コメントが1文字の時' do
      it '有効である' do
        comment = build(:comment, content: "a"*1 )
        expect(comment).to be_valid
      end
    end

    context 'コメントが999文字の時' do
      it '有効である' do
        comment = build(:comment, content: "a"*999 )
        expect(comment).to be_valid
      end
    end

    context 'コメントが1000文字の時' do
      it '有効である' do
        comment = build(:comment, content: "a"*1000 )
        expect(comment).to be_valid
      end
    end

    context 'コメントで全角で1000文字の時' do
      it '有効である' do
        comment = build(:comment, content: "あ"*1000 )
        expect(comment).to be_valid
      end
    end

    context 'コメントが1001文字の時' do
      it '無効である' do
        comment = build(:comment, content: "a"*1001 )
        comment.valid?
        expect(comment).to be_invalid
      end
    end

    context 'コメントが1001文字の時' do
      it '適切なエラーが出る' do
        comment = build(:comment, content: "a"*1001 )
        comment.valid?
        expect(comment.errors.full_messages).to eq ["Contentは1000文字以内で入力してください"]
      end
    end

  end

  describe '画像のバリデーション' do

    context '画像ファイル形式がjpgの時' do
      it '有効である' do
        comment = build(:comment, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg')) )
        expect(comment).to be_valid
      end
    end

    context '画像ファイル形式がpngの時' do
      it '有効である' do
        comment = build(:comment, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sansen.png')) )
        expect(comment).to be_valid
      end
    end

    context '画像ファイル形式がgifの時' do
      it '有効である' do
        comment = build(:comment, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/test.gif')) )
        expect(comment).to be_valid
      end
    end

  end
end
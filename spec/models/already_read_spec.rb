RSpec.describe AlreadyRead, type: :model do
  describe '既読機能' do

    context '投稿と投稿を見たユーザーが存在する時' do
      it '有効である' do
        alreadyread = create(:already_read)
        expect(alreadyread).to be_valid
      end
    end

    context '投稿が存在しない時' do
      it '無効である' do
        alreadyread = build(:already_read, :skip_validate, post_id: nil)
        alreadyread.valid?
        expect(alreadyread).to be_invalid
      end
    end

    context '投稿を見たユーザーが存在しない時' do
      it '無効である' do
        alreadyread = build(:already_read, :skip_validate, user_id: nil)
        alreadyread.valid?
        expect(alreadyread).to be_invalid
      end
    end
  end

end

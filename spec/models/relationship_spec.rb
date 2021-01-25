RSpec.describe Relationship, type: :model do
  describe 'フォローフォロワー機能' do

    context 'フォローフォロワーが存在する時' do
      it '有効である' do
        relationship = create(:relationship)
        expect(relationship).to be_valid
      end
    end

    context 'フォローする人が存在しない時' do

      it '無効である' do
        relationship = create(:relationship, :skip_validate, user_id: nil)
        expect(relationship).to be_invalid
      end

      it '適切なエラーが表示される' do
        relationship = create(:relationship, :skip_validate, user_id: nil)
        relationship.valid?
        #↓出てくるエラーが["Userを入力してください", "Userを入力してください"]と出るためincludeを使っています
        expect(relationship.errors.full_messages).to include("Userを入力してください")
      end
    end

    context 'フォローされる人が存在しない時' do

      it '無効である' do
        relationship = create(:relationship, :skip_validate, follow_id: nil)
        expect(relationship).to be_invalid
      end

      it '適切なエラーが表示される' do
        relationship = create(:relationship, :skip_validate, follow_id: nil)
        relationship.valid?
        #↓出てくるエラーが["Followを入力してください", "Followを入力してください"]と出るためincludeを使っています
        expect(relationship.errors.full_messages).to include("Followを入力してください")
      end
    end

  end

end

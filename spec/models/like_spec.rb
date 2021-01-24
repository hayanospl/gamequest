RSpec.describe Like, type: :model do
  describe '投稿(post)をいいねする' do

    context 'いいねした時' do
      it '有効である' do
        like = build(:like)
        expect(like).to be_valid
      end
    end

  end

end

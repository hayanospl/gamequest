RSpec.describe CommentLike, type: :model do
  describe '投稿(post)をいいねする' do

    context 'いいねした時' do
      it '有効である' do
        commentlike = build(:commentlike)
        expect(commentlike).to be_valid
      end
    end

  end

end

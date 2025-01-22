require 'rails_helper'

RSpec.describe Tree, type: :model do
  let(:user) { create(:user) }

  context 'バリデーション' do
    it '有効なTreeが自動的に作成される' do
      expect(user.tree).to be_present
      expect(user.tree).to be_valid
    end

    it 'user_idが一意であることを検証する' do
      expect { Tree.create!(user: user) }.to raise_error(ActiveRecord::RecordInvalid, /User has already been taken/)
    end
  end

  describe '#can_train?' do
    let(:tree) { user.tree }

    it '特訓可能な場合はtrueを返す' do
      tree.update!(last_trained_at: nil)
      expect(tree.can_train?).to be true
    end

    it '特訓不可能な場合はfalseを返す' do
      tree.update!(last_trained_at: Date.today)
      expect(tree.can_train?).to be false
    end
  end

  describe '#train!' do
    let(:tree) { user.tree } # 既存のTreeを利用する

    it '特訓が実行され、レベルが増加する' do
      tree.update!(level: 9, job: 'Seedlings')
      tree.train!
      expect(tree.level).to eq(10)
    end

    it '特訓が実行され、レベルがリセットされる場合' do
      tree.update!(level: 10, job: 'young tree')
      tree.train!
      expect(tree.level).to eq(0)
    expect(tree.job).to eq('mature tree')
    end
  end
end

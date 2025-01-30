# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tree, type: :model do
  let(:user) { create(:user) }
  let(:tree) { user.tree }

  context I18n.t('rspec.validations') do
    it I18n.t('rspec.auto_create_valid_tree') do
      expect(user.tree).to be_present
      expect(user.tree).to be_valid
    end

    it I18n.t('rspec.unique_user_id') do
      expect { Tree.create!(user: user) }.to raise_error(ActiveRecord::RecordInvalid, /User has already been taken/)
    end
  end

  describe I18n.t('rspec.methods.can_train') do
    before do
      tree.update!(last_trained_at: nil) # 確実にリセット
      tree.reload
    end

    it I18n.t('rspec.trainable_returns_true') do
      tree.update!(last_trained_at: nil) # nil の場合は true になる
      tree.reload

      puts "Debug: tree.last_trained_at=#{tree.last_trained_at}, Time.zone.today=#{Time.zone.today}"

      expect(tree.can_train?).to be true
    end

    it I18n.t('rspec.untrainable_returns_false') do
      tree.update!(last_trained_at: Time.zone.today) # 直接更新し、確実にセットする
      tree.reload

      puts "Debug: tree.last_trained_at=#{tree.last_trained_at}, Time.zone.today=#{Time.zone.today}"

      expect(tree.can_train?).to be false
    end
  end

  describe I18n.t('rspec.methods.train') do
    before do
      tree.update!(level: 0, job: 'Seedlings')
      tree.reload
    end

    it I18n.t('rspec.training_increases_level') do
      tree.update!(level: 9, job: 'Seedlings')
      tree.train!

      expect(tree.level).to eq(10)
    end

    it I18n.t('rspec.training_resets_level_and_promotes') do
      tree.update!(level: 10, job: 'young tree')
      tree.train!

      expect(tree.level).to eq(0)
      expect(tree.job).to eq('mature tree')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe I18n.t('rspec.validations') do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe I18n.t('rspec.associations') do
    it { is_expected.to belong_to(:user) }
  end

  describe I18n.t('rspec.methods.japanese_font_name') do
    it I18n.t('rspec.returns_default_value') do
      diary = build(:diary, japanese_font_name: nil)
      expect(diary.japanese_font_name).to eq('Noto Sans JP')
    end
  end
end

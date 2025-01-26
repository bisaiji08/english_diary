# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :diaries
  has_one :tree, dependent: :destroy
  has_many :purchases
  has_many :purchased_items, through: :purchases, source: :item

  after_create :create_tree

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[diaries purchases purchased_items tree]
  end

  def self.from_omniauth(auth)
    Rails.logger.info I18n.t('users.omniauth.log', auth: auth.inspect)

    if auth.info.email.blank?
      Rails.logger.error I18n.t('users.omniauth.error.email_missing', uid: auth.uid)
      raise StandardError, I18n.t('users.omniauth.error.failed_creation')
    end

    transaction do
      user = find_or_initialize_by(email: auth.info.email)

      if user.persisted?
        Rails.logger.info I18n.t('users.omniauth.log.existing_user', user: user.inspect)
        user.update!(provider: auth.provider, uid: auth.uid) if user.provider != auth.provider || user.uid != auth.uid
      else
        user.assign_attributes(
          provider: auth.provider,
          uid: auth.uid,
          password: Devise.friendly_token[0, 20],
          name: auth.info.name || I18n.t('users.omniauth.default_name'),
          image: auth.info.image
        )
        user.save!
      end

      user
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error I18n.t('users.omniauth.error.creation_failed', error: e.message)
      raise StandardError, I18n.t('users.omniauth.error.failed_creation')
    end
  end

  def purchased_fonts
    purchased_items.where(category: 'Font')
  end

  private

  def create_tree
    create_tree!
  end

  def available_fonts
    Item.where(font_name: ['Noto Sans', 'Noto Sans JP']) + purchased_fonts
  end
end

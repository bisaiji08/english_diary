class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :diaries
  has_one :tree, dependent: :destroy
  has_many :purchases
  has_many :purchased_items, through: :purchases, source: :item

  after_create :create_tree

  def self.from_omniauth(auth)
    Rails.logger.info "OmniAuth Auth Data: #{auth.inspect}"

    # 必須項目の検証
    if auth.info.email.blank?
      Rails.logger.error "OmniAuth Error: Email is missing for UID: #{auth.uid}"
      return nil
    end

    # メールアドレスで既存ユーザーを検索
    user = find_by(email: auth.info.email)

    if user
      Rails.logger.info "Existing user found: #{user.inspect}"

      # プロバイダー情報が異なる場合のみ更新
      if user.provider != auth.provider || user.uid != auth.uid
        Rails.logger.info "Updating provider and UID for user: #{user.email}"
        user.update(provider: auth.provider, uid: auth.uid)
      end
    else
      Rails.logger.info "Creating new user for OmniAuth data"
      # プロバイダーとUIDで新しいユーザーを初期化
      user = new(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name,
        image: auth.info.image
      )

      unless user.save
        Rails.logger.error "User creation failed: #{user.errors.full_messages}"
        return nil
      end

      Rails.logger.info "User successfully created: #{user.inspect}"
    end

    user
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

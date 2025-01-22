class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :diaries
  has_one :tree, dependent: :destroy
  has_many :purchases
  has_many :purchased_items, through: :purchases, source: :item

  after_create :create_tree

  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "name", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["diaries", "purchases", "purchased_items", "tree"]
  end

  def self.from_omniauth(auth)
    Rails.logger.info "OmniAuth Auth Data: #{auth.inspect}"
  
    # 必須項目の検証
    if auth.info.email.blank?
      Rails.logger.error "OmniAuth Error: Email is missing for UID: #{auth.uid}"
      raise StandardError, 'Failed to create user'
    end
  
    transaction do
      user = find_or_initialize_by(email: auth.info.email)
  
      if user.persisted?
        Rails.logger.info "Existing user found: #{user.inspect}"
  
        # プロバイダー情報を更新（必要な場合）
        if user.provider != auth.provider || user.uid != auth.uid
          Rails.logger.info "Updating provider and UID for user: #{user.email}"
          user.update!(provider: auth.provider, uid: auth.uid)
        end
      else
        Rails.logger.info "Creating new user for OmniAuth data"
        # 新規ユーザー作成
        user.assign_attributes(
          provider: auth.provider,
          uid: auth.uid,
          password: Devise.friendly_token[0, 20],
          name: auth.info.name || "Google User",
          image: auth.info.image
        )
  
        # 保存に失敗した場合はエラーを投げる
        user.save!
        Rails.logger.info "User successfully created: #{user.inspect}"
      end
  
      user
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "User creation failed: #{e.message}"
      raise StandardError, 'Failed to create user'
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

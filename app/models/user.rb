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
    Rails.logger.info("OmniAuth Auth Data: #{auth.inspect}")
    # 必須項目の検証
    if auth.info.email.blank?
      Rails.logger.error("OmniAuth Error: Email is missing for UID: #{auth.uid}")
      return nil
    end
  
    # メールアドレスで既存ユーザーを検索
    user = find_by(email: auth.info.email)

    # 既存ユーザーが見つかった場合、プロバイダー情報を更新
    if user
      user.update(provider: auth.provider, uid: auth.uid) if user.provider.blank? || user.uid.blank?
    else
      # プロバイダーとUIDで新しいユーザーを初期化
      user = new(provider: auth.provider, uid: auth.uid, email: auth.info.email) do |u|
        u.password = Devise.friendly_token[0, 20]
        u.name = auth.info.name if u.respond_to?(:name) # 名前を保存する場合
        u.image = auth.info.image if u.respond_to?(:image) # プロフィール画像を保存する場合
      end

      # ユーザーの保存
      unless user.save
        Rails.logger.error("OmniAuth Error: User creation failed for UID: #{auth.uid}, Errors: #{user.errors.full_messages}")
        user.errors.add(:base, "User could not be created")
        eturn user
      end
    end
  
    user
  end
  
  

  def purchased_fonts
    purchased_items.where(category: 'Font')
  end

  private

  def create_tree
    self.create_tree!
  end

  def available_fonts
    Item.where(font_name: ['Noto Sans', 'Noto Sans JP']) + purchased_fonts
  end
end

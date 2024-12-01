class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries
  has_one :tree, dependent: :destroy

  after_create :create_tree

  has_many :purchases
  has_many :items, through: :purchases

  private

  def create_tree
    self.create_tree!
  end
end

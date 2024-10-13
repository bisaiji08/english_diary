class Diary < ApplicationRecord
  validates :title, presence: true
end

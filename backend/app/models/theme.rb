class Theme < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
end

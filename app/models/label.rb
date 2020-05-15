class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings, source: :task

  belongs_to :user

  validates :name, presence: true
end

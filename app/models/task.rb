class Task < ApplicationRecord
  enum priority: %i[高 中 低]
  belongs_to :user, optional: true

  has_many :labellings, dependent: :destroy
  has_many :labelling_labels, through: :labellings, source: :label

  validates :title, presence: true
  validates :content, presence: true

  scope :search, lambda { |title_search, status_search, label_ids|
    if title_search.present? && status_search.present?
      Task.where('title like? AND status like?', "%#{title_search}%", status_search.to_s)
    elsif title_search.present?
      Task.where('title like?', "%#{title_search}%")
    elsif status_search.present?
      Task.where(status: status_search)
    elsif label_ids.present?
      task_research(label_ids)
    end
  }
end

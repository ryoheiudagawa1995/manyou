class Task < ApplicationRecord
  enum priority: %i[高 中 低]
  belongs_to :user, optional: true

  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label

  validates :title, presence: true
  validates :content, presence: true


  scope :search, -> (title_search, status_search, label_id) {
    if title_search.present? && status_search.present?
      where('title like? AND status like?', "%#{title_search}%", status_search.to_s)
    elsif title_search.present?
      where('title like?', "%#{title_search}%")
    elsif status_search.present?
      where(status: status_search)
    elsif label_id.present?
      where(id: Labelling.where(label_id: label_id).pluck(:task_id))
    end
  }
end

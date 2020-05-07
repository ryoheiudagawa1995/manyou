class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search, ->(search, title_search, status_search) do
    if search.present?
      if title_search.present? and title_search.present?
        return Task.where("title like ? AND status like ?", "%#{ title_search }%", "#{ status_search }")
      elsif title_search.present?
        return Task.where("title like", "%#{ title_search }%")
      elsif status_search.present?
        return Task.where(status: status_search)
      end
    end
  end
end

class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labelling_tasks, through: :labellings, source: :task

end

module LabelsHelper

  def task_research(label_ids)
    label_ids.each do |label|
    Label.where(label_id: label).labelling_tasks
  end

end

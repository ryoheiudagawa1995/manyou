module LabellingsHelper
  def task_id_research
    params[:label_ids].each do |label|
       Labelling.where(label_id: label).pluck(:task_id)
    end
  end
end

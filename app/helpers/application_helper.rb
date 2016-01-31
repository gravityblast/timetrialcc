module ApplicationHelper
  def body_class_name
    "c-#{controller_path.parameterize} a-#{params[:action]}"
  end
end

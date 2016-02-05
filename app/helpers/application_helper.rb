module ApplicationHelper
  def each_flash_message
    (flash[:messages] || {}).each do |k, v|
      yield k.to_s, v
    end
  end

  def body_class_name
    "c-#{controller_path.parameterize} a-#{params[:action]}"
  end

  def trackable_events
    (flash['events'] || []).map do |event|
      {
        c: event['category'],
        a: event['action'],
        l: event['label'],
        v: event['value']
      }
    end
  end

  def body_data
    {
      widget: 'events-tracker',
      events: trackable_events
    }
  end

  def flash_to_bootstrap k
    case k
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'alert'
      'warning'
    when 'notice'
      'info'
    else
      k.to_s
    end
  end
end

module ApplicationHelper
  def flash_class(message_type)
    case message_type.to_sym
    when :notice
      'success'  # 緑色
    when :alert
      'danger'   # 赤色
    when :success
      'success'  # 緑色
    when :danger
      'danger'   # 赤色
    when :info
      'info'     # 青色
    when :warning
      'warning'  # 黄色
    else
      'secondary' # グレー
    end
  end
end

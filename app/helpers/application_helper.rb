module ApplicationHelper

  def count
    @count = current_user.notifications.where(read: false).count
    @count
  end

  def notifications
    @notifications = current_user.notifications.order(id: :desc) if user_signed_in?
  end

end

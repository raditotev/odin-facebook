module ApplicationHelper

  def count
    @count = current_user.notifications.where(read: false).count
    @count
  end

end

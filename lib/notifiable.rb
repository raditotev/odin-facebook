module Notifiable
  def self.included(klass)
    klass.class_eval do
      after_create :create_notification

      has_one :notification, as: :notifiable, dependent: :destroy

      def create_notification

        user = case self
        when Like, Comment then self.post.author
        when Invitation then self.to_user
        end
        Notification.create!(user:user, notifiable: self)
      end
    end
  end
end

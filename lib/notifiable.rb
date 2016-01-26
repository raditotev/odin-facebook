module Notifiable
  def self.included(klass)
    klass.class_eval do
      after_create :create_notification

      has_one :notification, as: :notifiable, dependent: :destroy

      def create_notification

        author = case self
        when Like, Comment then self.post.author
        when Invitation then self.to_user
        end

        user = case self
          when Like, Comment then self.user
        end

        Notification.create!(user:author, notifiable: self) unless author == user
      end
    end
  end
end

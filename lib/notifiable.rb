module Notifiable
  def self.included(klass)
    klass.class_eval do
      has_one :notification, as: :notifiable,
      dependent: :destroy
    end
  end
end

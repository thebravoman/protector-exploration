class Article < ActiveRecord::Base
  belongs_to :user

  protect do |user|
    if user.try(:admin?)
      scope { all }
    else
      scope { where(hidden: false) }
      can :read

      if user.nil?
        cannot :read, :text
      end

      can :create, %w(title text)
      can :create, user_id: lambda { |x|
        x == user.ids
      }
    end

  end

end

class User < ActiveRecord::Base

  def admin?
    role == "admin"
  end

end

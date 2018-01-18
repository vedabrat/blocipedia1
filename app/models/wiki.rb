class Wiki < ApplicationRecord
  belongs_to :user

  def publicize
    update_attribute(:private, false)
  end

  def self.visible_to(user)
    if user.try(:role) == 'premium' || user.try(:role) == 'admin'
      all
    else
      where(private: false)
    end
  end
end

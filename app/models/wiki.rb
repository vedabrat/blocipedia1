class Wiki < ApplicationRecord
  belongs_to :user
    has_many :collaborators
     has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def publicize
    update_attribute(:private, false)
  end

end

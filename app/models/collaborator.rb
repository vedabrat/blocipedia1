class Collaborator < ApplicationRecord
    belongs_to :user
     belongs_to :wiki

     @user_options = User.all.map { |u| [ u.email, u.id] }

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborators
  has_many :wikis, through: :collaborators

  before_save { self.email = email.downcase }


  has_many :wikis

  after_initialize { self.role ||= :standard }
  enum role: [:standard, :admin, :premium]


    def upgrade
      update!(role: :premium)
    end

  def going_public
    self.wikis.each { |wiki| puts wiki.publicize }
  end

end

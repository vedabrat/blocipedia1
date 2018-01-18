class WelcomeController < ApplicationController
    # before_filter :authenticate_user!, except: [ :index, :about ]

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def about
  end
end

class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def new
    @collaborator = Collaborator.new
  end

  def edit
    @user_options = User.all.map { |u| [ u.email, u.id] }
  end

  #
  # Collaborator.create(user: user, wiki: wiki)
  # Collaborator.create(user_id: user.id, wiki_id: wiki.id)
  # (you can already access @user_options that gives username and user_id)


  def create(user, wiki, collaborator)
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end

  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      render :show
    end
  end

  def _form
    binding.pry
  end

private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end


end

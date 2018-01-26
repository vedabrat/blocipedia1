class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @collaborators = @wiki.collaborators.includes(:user)
    @new_collaborator = @wiki.collaborators.new
    @non_collab_users = User.where.not(id: @collaborators.pluck(:id))
  end

  def create
    @collaborator = @wiki.collaborators.new(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to wiki_collab_path
    else
      flash[:error] = "Collaborator was not added. Please try again."
      redirect_to wiki_collab_path
    end

  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to wiki_collab_path
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      redirect_to wiki_collab_path
    end
  end

  private

  def wiki_collab_path
    wiki_collaborators_path(wiki_id: @wiki)
  end

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:user_id)
  end
end

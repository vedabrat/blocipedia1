class WikisController < ApplicationController
    # before_filter :authenticate_user!, except: [ :index, :show ]
    after_action :verify_authorized, :except => :index
  def index
    @wikis = Wiki.all
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
    if current_user.present?
     collaborators = []
     @wiki.collaborators.each do |collaborator|
       collaborators << collaborator.email
     end
     unless (@wiki.private == false) || @wiki.user == current_user || collaborators.include?(current_user.email) || current_user.admin?
       flash[:alert] = "You are not authorized to view this wiki."
       redirect_to new_charge_path
     end
   else
     flash[:alert] = "You are not authorized to view this wiki."
     redirect_to new_user_registration_path
       end
     end
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
     @wiki = Wiki.create(wiki_params)
     @wiki.user = current_user
     authorize @wiki
     if @wiki.save
       @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])

       flash[:notice] = "wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "Error creating wiki. Please try again."

     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
      @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end

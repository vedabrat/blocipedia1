class WikisController < ApplicationController
  after_action :verify_authorized, :except => :index
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaboration = @wiki.collaborators.map { |c| [c.email, c.id] }

    unless (@wiki.private == false) || (@wiki.private == nil) || current_user.premium? || current_user.admin?
      flash[:alert] = "You must be a premium user to view private topics."
      if current_user
        redirect_to new_charge_path
      else
        redirect_to new_user_registration_path
      end
    end
    authorize @wiki
  end

  def new
    @user_options = User.all.map { |u| [ u.email, u.id] }
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.create(wiki_params)
    @wiki.user = current_user
    @user_options = User.all.map { |u| [ u.email, u.id] }
    authorize @wiki
    if @wiki.save
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

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaborator)
  end
end

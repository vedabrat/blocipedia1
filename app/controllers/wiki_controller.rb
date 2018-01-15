class WikiController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
     @wiki = Wiki.create(wiki_params)

     if @wiki.save
       flash[:notice] = "wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "Error creating wiki. Please try again."

     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    if @wiki.save
      flash[:notice] = "wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "Error creating wiki. Please try again."

    end
  end

  def destroy
     @wiki = Wiki.find(params[:id])

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
    params.require(:wiki).permit(:title, :body, :public)
  end
end

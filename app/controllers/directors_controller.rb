class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end

  def create
    @director = Director.new(params.require(:director).permit(:name, :dob, :bio))
    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "Director created successfully."
    else
      render "directors/new"
    end
  end

  def index
    @directors = Director.order(created_at: :desc)
    respond_to do |format|
      format.json do
        render json: @directors
      end

      format.html
    end
  end

  def show
    @director = Director.find(params.fetch(:id))
  end

  def edit
    @director = Director.find(params.fetch(:id))
  end

  def update
    @director = Director.find(params.fetch(:id))
    @director.name = params.fetch(:director).fetch(:name)
    @director.dob = params.fetch(:director).fetch(:dob)
    @director.bio = params.fetch(:director).fetch(:bio)

    if @director.valid?
      @director.save
      redirect_to "#{director_url(@director)}", notice: "Director updated successfully."
    else
      redirect_to "#{director_url(@director)}", alert: "Director failed to update successfully."
    end
  end

  def destroy
    @director = Director.find(params.fetch(:id))
    @director.destroy

    redirect_to directors_url, notice: "Director deleted successfully."
  end
end

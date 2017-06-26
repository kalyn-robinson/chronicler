class CharactersController < ApplicationController
  before_action :set_character,   only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy, :restore]
  before_action :correct_belongs, only: [:edit, :update, :destroy]
  before_action :admin_user,      only: [:restore]

  # GET /characters
  def index
    @characters = show_deleted(Character, params[:page])
  end

  # GET /characters/1
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  def create
    @character = current_user.characters.build(character_params)

    if @character.save
      flash[:success] = 'Character was successfully created.'
      redirect_to @character
    else
      render 'new'
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update_attributes(character_params)
      flash[:success] = 'Character successfully updated.'
      redirect_to @character
    else
      render 'edit'
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
    flash[:success] = 'Character successfully destroyed.'
    redirect_to characters_url
  end

  def restore
    @character = Character.with_deleted.find(params[:id])

    if @character.restore
      flash[:success] = 'Character successfully restored.'
    else
      flash[:danger] = 'Character could not be restored.'
    end
    
    redirect_to characters_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :user_id)
    end

    # Confirms the correct user.
    def correct_belongs
      unless current_user.id == @character.user.id
        flash[:danger] = 'You cannot perform this action.'
        redirect_to(root_url)
      end
    end
end

class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
    @notes = Note.all
  end

  def create
     @note = Note.new(note_params)

    if @note.save
      redirect_to @note, notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  def edit
    @notes = Note.all
  end

  def update
    if @note.update(note_params)
      head :no_content
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end
  def complete
    @note = Note.find(params[:id])
    @note.update(completed: true)
    
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully marked as complete.' }
      format.json { render json: @note, status: :ok }
    end
  end
  
  def incomplete
    @note = Note.find(params[:id])
    @note.update(completed: false)
    
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was marked as incomplete.' }
      format.json { render json: @note, status: :ok }
    end
  end


  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.js   { render layout: false }
    end
  end




  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :completed)
  end
end

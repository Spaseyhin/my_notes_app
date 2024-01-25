class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.order(pinned: :desc, completed: :asc, created_at: :desc)
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
      redirect_to notes_url, notice: 'Note was successfully created.'
    else
      render :new
    end
  end


  def edit
    @notes = Note.all
  end


  def update
  if @note.update(note_params)
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully updated.' }
      format.json { head :no_content }
    end
  else
    render :edit
  end
end

  def completed
    @note = Note.find(params[:id])
    @note.update(completed: true)

    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was marked as completed.' }
      format.json { render json: @note, status: :ok }
    end
  end
    def not_completed
    @note = Note.find(params[:id])
    @note.update(completed: false)

    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was marked as not completed.' }
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

  def pin
    @note = Note.find(params[:id])
    @note.update(pinned: true)
    
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully pinned.' }
      format.json { render json: @note, status: :ok }
    end
  end

  def unpin
    @note = Note.find(params[:id])
    @note.update(pinned: false)

    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully unpinned.' }
      format.json { render json: @note, status: :ok }
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

class NotesController < ApplicationController
  def api_create
    @note = Note.create(params_check)
    render json: @note, status: 201
  end

  def api_show
    @account_notes = Note.notes_by_account(params[:accid])
    index = params[:noteid].to_i
    @note_index = @account_notes.find_index {|e| e.id == index}
    @previous_note = @account_notes[@note_index - 1]
    render json: @previous_note, status: 201
  end

  private

  def params_check
    params.require(:note).permit(:id, :account_id, :content)
  end
end

class NotesController < ApplicationController
  def create
    @note = Note.create(params_check)
    render json: @note, status: 201
  end

  private

  def params_check
    params.require(:note).permit(:account_id, :content)
  end
end

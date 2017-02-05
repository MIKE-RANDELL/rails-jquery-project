class NotesController < ApplicationController
  def api_create
    @note = Note.create(params_check)
    render json: @note, status: 201
  end

  def api_show
    binding.pry
    @account = Account.find(params[:accid])
    @account_notes = Note.notes_by_account(params[:accid])

  end

  private

  def params_check
    params.require(:note).permit(:id, :account_id, :content)
  end
end

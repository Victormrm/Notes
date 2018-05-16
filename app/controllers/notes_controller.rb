class NotesController < ApplicationController
	before_action :find_note,only: [:show,:update,:edit,:destroy]
	def index
		@notes = Note.all.order("created_at DESC")
	end
	
	def show
	
	end
	
	def new
		@note = Note.new
	end
	
	def create
	#solucionar esos id_id
		@note = Note.new(note_params)
		@note.user = User.find_by name: session[:user]
		@note.collection = Collection.find_by id:[1]
		respond_to do |format|
			if @note.save!
				format.html {redirect_to @note, notice: 'Note was successfully created.' }
				format.json { render :show, status: :created, location: @note }
			else
				format.html { render :new }
				format.json { render json: @note.errors, status: :unprocessable_entity }
				
			end
		end
	end
	
	def edit
	end
	
	def update
		if @note.update(note_params)
			redirect_to @note
		else
			render 'edit'
		end
	end
	
	def destroy
		@note.destroy
		redirect_to notes_path
	end
	
	private
	
	def find_note
		@note = Note.find(params[:id])
	end
	def note_params
		params.require(:note).permit(:title,:content)
	end
end

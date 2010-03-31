class ShoutboxesController < ApplicationController

	def index
		list
		render :action => 'list'
	end

	def list
		@shoutbox_pages, @shoutboxes = paginate :shoutboxes, :per_page => 10
	end

	def show
		@shoutbox = Shoutbox.find(params[:id])
	end

	def new
		@shoutbox = Shoutbox.new
	end

	def create
		@shoutbox = Shoutbox.new(params[:shoutbox])
		if @shoutbox.save
			flash[:notice] = 'Shoutbox was successfully created.'
			redirect_to root_path
		else
			render :action => 'new'
		end
	end
end


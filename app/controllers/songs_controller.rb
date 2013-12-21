
class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy, :starred, :unstarred, :starredhome, :unstarredhome, :unstarredatfaves, :starredsource, :unstarredsource]

    # acts_as_votable
    def starred
      @song.vote_by current_user
      redirect_to @song
    end

    def unstarred
      @song.unliked_by current_user
      redirect_to @song
    end
    def starredsource
      @song.vote_by current_user
      source_redirect = @song.source
      redirect_to :controller =>"songs", :action => "source", :source => source_redirect
    end

    def unstarredsource
      @song.unliked_by current_user
      source_redirect = @song.source
      redirect_to :controller =>"songs", :action => "source", :source => source_redirect
    end

    def starredhome
      @song.vote_by current_user
      redirect_to root_path
    end

    def unstarredhome
      @song.unliked_by current_user
      redirect_to root_path
    end
    def unstarredatfaves
      @song.unliked_by current_user
      redirect_to "/myfaves" 
    end
    def myfaves
    # @songs = Song.page(params[:page]).order('created_at DESC')
    # @songs.per_page = 5
    require 'will_paginate/array'
    #@user_likes = current_user.find_liked_items.per_page(5)

    @user_likes = current_user.find_liked_items.paginate(:page => params[:page], :per_page => 20)

    end
    def source
      if params[:source] 
        @songs = Song.where(:source => params[:source]).paginate(:page => params[:page], :per_page => 20)
 
        else 
      end
    end
  # GET /songs
  # GET /songs.json
  def index
    # @songs = Song.all(order:'created_at desc')
    #Pagination
    @songs = Song.page(params[:page]).order('created_at DESC')
    @songs.per_page = 20
  end


  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @song }
      else
        format.html { render action: 'new' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title, :youtubeid, :bloglink, :source)
    end

end

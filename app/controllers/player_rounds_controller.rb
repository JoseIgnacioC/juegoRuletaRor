class PlayerRoundsController < ApplicationController
  before_action :set_player_round, only: [:show, :edit, :update, :destroy]

  # GET /player_rounds
  # GET /player_rounds.json
  def index
    @player_rounds = PlayerRound.all
  end

  # GET /player_rounds/1
  # GET /player_rounds/1.json
  def show
  end

  # GET /player_rounds/new
  def new
    @round = Round.find(params[:round_id])
    @player_round = PlayerRound.new()
  end

  # GET /player_rounds/1/edit
  def edit
  end

  # POST /player_rounds
  # POST /player_rounds.json
  def create
    
    for player in Player.all do

      puts player.name

      @player = player
      @amount = 5000
      @round = Round.find(params[:round_id])
      @player_round = PlayerRound.new({
        :amount => @amount,
        :round => @round,
        :player => @player
      })    

      puts @round.conservative

      if @player_round.save()
        varAux = true
      else
        varAux = false
      end
    end

    if varAux
      redirect_to @round, notice => "La apuesta ha sido agregada"      
    else
      redirect_to @round, notice => "La apuesta NO ha sido agregada"      
    end    
  end

  # PATCH/PUT /player_rounds/1
  # PATCH/PUT /player_rounds/1.json
  def update
    respond_to do |format|
      if @player_round.update(player_round_params)
        format.html { redirect_to @player_round, notice: 'Player round was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_round }
      else
        format.html { render :edit }
        format.json { render json: @player_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_rounds/1
  # DELETE /player_rounds/1.json
  def destroy
    @player_round.destroy
    respond_to do |format|
      format.html { redirect_to player_rounds_url, notice: 'Player round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_round
      @player_round = PlayerRound.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_round_params
      params.require(:player_round).permit(:amount)
    end
end

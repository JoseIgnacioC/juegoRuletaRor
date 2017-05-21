class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id])
    @player_rounds = PlayerRound.select("id, amount, betValue, player_id, round_id").where(:round_id => params[:id])
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)
    

    @dateTime = Time.new
    @conservative = false
    @result = resultRulleteBet

    @round.dateTime = @dateTime
    @round.conservative = @conservative
    @round.result = @result

    
    if @round.save
      puts "El indice es: "
      puts @round.id
      addPlayerRound(@round.id)
    else
      format.html { render :new }
      format.json { render json: @round.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addPlayerRound(round_id)

    for player in Player.all do

      puts player.name

      @player = player      
      @round = Round.find(round_id)

      puts "el dinero que tiene es:"
      puts player.money

      @amount = amountBet(player.money, @round.conservative)

      @betValue = resultRulleteBet

      @player_round = PlayerRound.new({
        :amount => @amount,
        :round => @round,
        :player => @player,
        :betValue => @betValue
      })    

      puts @round.conservative

      if @player_round.save()
        varAux = true
        playRound(@amount, @betValue, @round.result, @player)
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

  def playRound(amount, betValue, result, player)  

    amountWon = amount * -1

    puts "PlayRound"
    puts player.name
    puts player.money
    puts amountWon

    if betValue == result

      if betValue == 'Verde'
        amountWon = amountWon + (amount*15)
      elsif betValue == 'Rojo' or betValue == 'Negro'
        amountWon = amountWon + (amount*2)
      else
        puts 'Error en colores'        
      end        
    end    

    puts amountWon
    newMoney = amountWon + player.money

    player.money = newMoney
    player.save()
  end


  def amountBet(money, conservative)

    puts "money es:"
    puts money

    betMoney = 0

    if(conservative)
      prob = Random.new.rand(4..10)      
    else
      prob = Random.new.rand(8..15)
    end

    prob = (prob * 1.0) / 100    

    if money < 1000 and money != 0
      betMoney = money
    elsif money != 0
      betMoney = money * prob
    end
      
    betMoney = betMoney.to_i
    puts betMoney

    return betMoney          

  end

  def resultRulleteBet

    
    prob = Random.new.rand(1..100)
    result = ""

    puts prob

    if prob <= 2
      result = "Verde"
    elsif prob >= 3 and prob <= 51
      result = "Rojo"
    else
      result = "Negro"
    end
        
    return result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:number)
    end
end
